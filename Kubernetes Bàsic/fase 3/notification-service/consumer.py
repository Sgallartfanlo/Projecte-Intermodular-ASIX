import json, os, pika

RABBIT_HOST = os.getenv("RABBIT_HOST", "message-queue")
QUEUE_NAME = os.getenv("QUEUE_NAME", "orders")

def callback(ch, method, properties, body):
    msg = json.loads(body.decode())
    print(f"[notification-service] Notificació rebuda: {msg}", flush=True)
    ch.basic_ack(delivery_tag=method.delivery_tag)

connection = pika.BlockingConnection(pika.ConnectionParameters(host=RABBIT_HOST))
channel = connection.channel()
channel.queue_declare(queue=QUEUE_NAME, durable=True)
channel.basic_qos(prefetch_count=1)
channel.basic_consume(queue=QUEUE_NAME, on_message_callback=callback)

print("[notification-service] Esperant missatges...", flush=True)
channel.start_consuming()
