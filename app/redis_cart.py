import redis
import random

# Connect to Redis container
r = redis.Redis(host="redis", port=6379, decode_responses=True)

def log(cmd: str):
    print(f"\n$ {cmd}")

customer_id = random.randint(1, 199)
cart_key = f"cart:{customer_id}"

print("\n===== REDIS CART COMMAND =====")

# 1️ Add items to cart
product1, product2 = random.randint(1, 150), random.randint(1, 150)

log(f"HINCRBY {cart_key} {product1} 1")
r.hincrby(cart_key, product1, 1)

log(f"HINCRBY {cart_key} {product2} 2")
r.hincrby(cart_key, product2, 2)

# 2️  View cart
log(f"HGETALL {cart_key}")
print("Cart:", r.hgetall(cart_key))

# 3️ Delete one product
log(f"HDEL {cart_key} {product1}")
r.hdel(cart_key, product1)

log(f"HGETALL {cart_key}")
print("Cart After Removing Item:", r.hgetall(cart_key))

# 4️ Clear entire cart
log(f"DEL {cart_key}")
r.delete(cart_key)

log(f"HGETALL {cart_key}")
print("Final Cart (should be empty):", r.hgetall(cart_key))
