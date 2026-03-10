import json, os
from flask import Flask, request, jsonify
import mysql.connector
import pika

app = Flask(__name__)

DBP_HOST = os.getenv("DBP_HOST", "db-products")
DBO_HOST = os.getenv("DBO_HOST", "db-orders")
DB_USER = os.getenv("DB_USER", "root")
DB_PASS = os.getenv("DB_PASS", "rootpassword")

DBP_NAME = os.getenv("DBP_NAME", "productsdb")
DBO_NAME = os.getenv("DBO_NAME", "ordersdb")

RABBIT_HOST = os.getenv("RABBIT_HOST", "message-queue")
QUEUE_NAME = os.getenv("QUEUE_NAME", "orders")

def conn_products():
    return mysql.connector.connect(host=DBP_HOST, user=DB_USER, password=DB_PASS, database=DBP_NAME)

def conn_orders():
    return mysql.connector.connect(host=DBO_HOST, user=DB_USER, password=DB_PASS, database=DBO_NAME)

def publish(msg: dict):
    connection = pika.BlockingConnection(pika.ConnectionParameters(host=RABBIT_HOST))
    channel = connection.channel()
    channel.queue_declare(queue=QUEUE_NAME, durable=True)
    channel.basic_publish(exchange="", routing_key=QUEUE_NAME, body=json.dumps(msg).encode())
    connection.close()

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/orders")
def create_order():
    data = request.get_json(force=True)
    user_id = int(data.get("user_id", 1))
    product_id = int(data["product_id"])
    qty = int(data.get("qty", 1))

    # 1) Descomptar stock a db-products
    cp = conn_products()
    curp = cp.cursor()
    curp.execute("SELECT stock FROM products WHERE id=%s", (product_id,))
    row = curp.fetchone()
    if not row:
        curp.close(); cp.close()
        return jsonify({"error": "product not found"}), 404
    stock = int(row[0])
    if stock < qty:
        curp.close(); cp.close()
        return jsonify({"error": "not enough stock", "stock": stock}), 400

    curp.execute("UPDATE products SET stock = stock - %s WHERE id=%s", (qty, product_id))
    cp.commit()
    curp.close(); cp.close()

    # 2) Crear comanda a db-orders
    co = conn_orders()
    curo = co.cursor()
    curo.execute(
        "INSERT INTO orders (user_id, product_id, qty, status) VALUES (%s,%s,%s,'CREATED')",
        (user_id, product_id, qty)
    )
    order_id = curo.lastrowid
    co.commit()
    curo.close(); co.close()

    # 3) Publicar missatge a RabbitMQ
    msg = {"order_id": order_id, "user_id": user_id, "product_id": product_id, "qty": qty}
    publish(msg)

    return jsonify({"status": "created", "order_id": order_id, "published": True})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
