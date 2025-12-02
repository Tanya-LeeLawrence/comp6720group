import pymysql
from pymongo import MongoClient
from neo4j import GraphDatabase
import redis
import time

# Small wait to allow DBs to start up fully
time.sleep(5)

# ---------- Test MySQL ----------
print("\n---- Testing MySQL ----")
mysql_conn = pymysql.connect(
    host="mysql", 
    user="appuser", 
    password="apppass",
    database="ecommerce",
    port=3306
)
with mysql_conn.cursor() as c:
    c.execute("SELECT DATABASE();")
    print("Connected to MySQL:", c.fetchone()[0])


# ---------- Test MongoDB ----------
print("\n---- Testing MongoDB ----")
mongo = MongoClient("mongodb://mongo:27017/")
print("MongoDB Databases:", mongo.list_database_names())


# ---------- Test Neo4j ----------
print("\n---- Testing Neo4j ----")
neo4j_driver = GraphDatabase.driver(
    "bolt://neo4j:7687", 
    auth=("neo4j", "password123")
)
with neo4j_driver.session() as session:
    result = session.run("RETURN 'Connected to Neo4j' AS msg")
    print(result.single()["msg"])


# ---------- Test Redis ----------
print("\n---- Testing Redis ----")
r = redis.Redis(host="redis", port=6379)
r.set("test", "hello redis")
print("Redis GET:", r.get("test").decode())


print("\nALL SYSTEMS CONNECTED SUCCESSFULLY 🚀")
