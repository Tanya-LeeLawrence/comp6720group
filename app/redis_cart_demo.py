import redis
import random

r = redis.Redis(host="redis", port=6379, decode_responses=True)

def add_to_cart(customer_id, product_id, qty):
    cart_key = f"cart:{customer_id}"
    r.hincrby(cart_key, product_id, qty)
    print(f"Added Product {product_id} x{qty} to Customer {customer_id}'s cart.")

def show_cart(customer_id):
    cart_key = f"cart:{customer_id}"
    items = r.hgetall(cart_key)
    if not items:
        print("Cart is empty.")
        return
    print(f"\nCustomer {customer_id}'s Cart:")
    for product_id, qty in items.items():
        print(f" - Product {product_id}: qty {qty}")

def clear_cart(customer_id):
    r.delete(f"cart:{customer_id}")
    print("Cart cleared.")

# Demo run
customer_id = random.randint(1, 199)
add_to_cart(customer_id, random.randint(1, 150), 1)
add_to_cart(customer_id, random.randint(1, 150), 2)
show_cart(customer_id)
