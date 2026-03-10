import json, os
from flask import Flask, jsonify
import mysql.connector
import redis

app = Flask(__name__)

DB_HOST = os.getenv("DB_HOST", "db-products")
DB_USER = os.getenv("DB_USER", "root")
DB_PASS = os.getenv("DB_PASS", "rootpassword")
DB_NAME = os.getenv("DB_NAME", "productsdb")

REDIS_HOST = os.getenv("REDIS_HOST", "cache")
REDIS_TTL = int(os.getenv("REDIS_TTL", "60"))

r = redis.Redis(host=REDIS_HOST, port=6379, decode_responses=True)

def db_conn():
    return mysql.connector.connect(
        host=DB_HOST, user=DB_USER, password=DB_PASS, database=DB_NAME
    )

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/products")
def products():
    cache_key = "products:list"
    cached = r.get(cache_key)
    if cached:
        return jsonify({"source": "redis", "items": json.loads(cached)})

    conn = db_conn()
    cur = conn.cursor(dictionary=True)
    cur.execute("SELECT id, name, price, stock FROM products")
    items = cur.fetchall()
    # Convertir Decimal a float per poder serialitzar a JSON
    for item in items:
        if 'price' in item:
            item['price'] = float(item['price'])
    cur.close()
    conn.close()

    r.setex(cache_key, REDIS_TTL, json.dumps(items))
    return jsonify({"source": "mysql", "items": items})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
