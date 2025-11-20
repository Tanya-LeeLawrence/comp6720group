import os
from dotenv import load_dotenv

load_dotenv()  # loads values from .env if present

class Config:
    # ---------- MySQL (Relational DB) ----------
    # Pattern taken from the Python + MySQL lab: host, user, password, database :contentReference[oaicite:3]{index=3}
    SQL_HOST = os.getenv("SQL_HOST", "localhost")
    SQL_USER = os.getenv("SQL_USER", "root")
    SQL_PASSWORD = os.getenv("SQL_PASSWORD", "your_password")
    SQL_DB = os.getenv("SQL_DB", "python_lab")  # or ecommerce

    # ---------- MongoDB (Document DB) ----------
    # Follows the lab idea of "use gradDB" by selecting the DB name explicitly :contentReference[oaicite:4]{index=4}
    MONGO_URI = os.getenv("MONGO_URI", "mongodb://localhost:27017/")
    MONGO_DB = os.getenv("MONGO_DB", "products")

    # ---------- Neo4j (Graph DB) ----------
    # Based on the Neo4j lab: URI + username + password (Aura/local) :contentReference[oaicite:5]{index=5}
    NEO4J_URI = os.getenv("NEO4J_URI", "bolt://localhost:7687")
    NEO4J_USER = os.getenv("NEO4J_USER", "neo4j")
    NEO4J_PASSWORD = os.getenv("NEO4J_PASSWORD", "password")

    # ---------- Redis (Key-Value Store) ----------
    REDIS_HOST = os.getenv("REDIS_HOST", "localhost")
    REDIS_PORT = int(os.getenv("REDIS_PORT", 6379))
