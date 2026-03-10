import os
from flask import Flask, request, jsonify
import mysql.connector

app = Flask(__name__)

DBO_HOST = os.getenv("DBO_HOST", "db-orders")
DB_USER = os.getenv("DB_USER", "root")
DB_PASS = os.getenv("DB_PASS", "rootpassword")
DBO_NAME = os.getenv("DBO_NAME", "ordersdb")

def conn_orders():
    return mysql.connector.connect(host=DBO_HOST, user=DB_USER, password=DB_PASS, database=DBO_NAME)

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/register")
def register():
    data = request.get_json(force=True)
    username = data["username"]
    password = data["password"]  # (simple per projecte)

    co = conn_orders()
    cur = co.cursor()
    cur.execute("INSERT INTO users (username, password) VALUES (%s,%s)", (username, password))
    co.commit()
    uid = cur.lastrowid
    cur.close(); co.close()
    return jsonify({"status": "ok", "user_id": uid})

@app.post("/login")
def login():
    data = request.get_json(force=True)
    username = data["username"]
    password = data["password"]

    co = conn_orders()
    cur = co.cursor()
    cur.execute("SELECT id FROM users WHERE username=%s AND password=%s", (username, password))
    row = cur.fetchone()
    cur.close(); co.close()

    if not row:
        return jsonify({"error": "invalid credentials"}), 401
    return jsonify({"status": "ok", "user_id": row[0]})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5002)
