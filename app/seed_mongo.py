import pymysql
from pymongo import MongoClient

# -------- MySQL connection (inside Docker network) --------
sql = pymysql.connect(
    host="mysql",           # <-- use docker-compose service name
    user="appuser",
    password="apppass",
    database="ecommerce",
    port=3306,
)

# -------- MongoDB connection --------
mongo = MongoClient("mongodb://mongo:27017/")  # <-- service name is 'mongo'
mdb = mongo["ecommerce"]

# Start clean
mdb.products.drop()

def get_attributes(category, name):
    category = category or ""
    if category == "Electronics":
        return {"brand": name.split()[0], "warranty": "1 Year"}
    if category == "Clothing":
        return {"gender": "Unisex", "sizes": ["S", "M", "L", "XL"]}
    if category == "Beachwear":
        return {"summer_wear": True, "waterproof": False}
    if category == "Food & Grocery":
        return {"brand": name.split()[0], "alcoholic": ("Rum" in name or "Beer" in name)}
    if category == "Beauty & Hair":
        return {"skin_safe": True}
    if category == "Sports & Outdoors":
        return {"sport_type": "General Fitness"}
    return {}

cur = sql.cursor()
cur.execute("SELECT product_id, sku, name, base_category, price FROM products")
rows = cur.fetchall()

count = 0
for (pid, sku, name, category, price) in rows:
    doc = {
        "product_id": int(pid),
        "sku": sku,
        "name": name,
        "category": category,
        "price": float(price),
        "attributes": get_attributes(category, name),
        "tags": [category.lower().replace(" ", "_")] if category else [],
    }
    mdb.products.insert_one(doc)
    count += 1

print(f"Inserted {count} product documents into MongoDB!")
