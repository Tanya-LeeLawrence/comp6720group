import redis
from config import Config

r = redis.Redis(
    host=Config.REDIS_HOST,
    port=Config.REDIS_PORT,
    decode_responses=True  # so we get strings, not bytes
)

# ---------- Basic Test ----------

def test_redis_connection():
    try:
        r.set("test_key", "hello")
        value = r.get("test_key")
        print("Redis test value:", value)
    except Exception as e:
        print(" Redis Error:", e)

# ---------- 1. Shopping Cart Functions ----------

def add_to_cart(user_id: int, product_id: str, qty: int = 1):
    """
    HINCRBY cart:<user_id> <product_id> qty
    Also set a TTL so carts expire after 1 hour.
    """
    key = f"cart:{user_id}"
    r.hincrby(key, product_id, qty)
    r.expire(key, 3600)  # 1 hour

def get_cart(user_id: int):
    """
    Returns all items in the user's cart as a dict {product_id: quantity}
    """
    key = f"cart:{user_id}"
    return r.hgetall(key)

def clear_cart(user_id: int):
    key = f"cart:{user_id}"
    r.delete(key)

# ---------- 2. Session Functions ----------

def create_session(token: str, user_id: int, ttl_seconds: int = 1800):
    """
    SETEX session:<token> ttl user_id
    """
    key = f"session:{token}"
    r.setex(key, ttl_seconds, user_id)

def get_session_user(token: str):
    """
    GET session:<token> -> user_id or None
    """
    key = f"session:{token}"
    return r.get(key)

# ---------- 3. Popular Products Ranking ----------

def increase_popularity(product_id: str, amount: float = 1.0):
    """
    ZINCRBY popular_products amount product_id
    """
    r.zincrby("popular_products", amount, product_id)

def get_popular(limit: int = 5):
    """
    Returns top N popular products as list of (product_id, score)
    """
    return r.zrevrange("popular_products", 0, limit - 1, withscores=True)
