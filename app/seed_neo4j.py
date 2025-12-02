import pymysql
from neo4j import GraphDatabase
import random
from datetime import datetime, timedelta

driver = GraphDatabase.driver(
    "bolt://neo4j:7687",
    auth=("neo4j", "password123")
)

mysql = pymysql.connect(
    host="mysql",
    user="appuser",
    password="apppass",
    database="ecommerce",
    port=3306
)

cur = mysql.cursor()

# Fetch correct customer fields
cur.execute("SELECT customer_id, full_name FROM customers")
customers = cur.fetchall()

# Fetch products
cur.execute("SELECT product_id, name, base_category FROM products")
products = cur.fetchall()


def seed():
    with driver.session() as session:
        print("Clearing old Neo4j graph...")
        session.run("MATCH (n) DETACH DELETE n")  

        print("Creating Product nodes...")
        for pid, name, category in products:
            session.run("""
                CREATE (:Product {
                    product_id: $pid,
                    name: $name,
                    category: $category
                })
            """, pid=pid, name=name, category=category)

        print("Creating Customer nodes & purchase relationships...")
        for cid, full_name in customers:
            session.run("""
                CREATE (:Customer {
                    customer_id: $cid,
                    name: $name
                })
            """, cid=cid, name=full_name)

            purchased = random.sample(products, 5)
            for prod_id, _, _ in purchased:
                qty = random.randint(1, 4)
                days_ago = random.randint(1, 150)
                date = (datetime.now() - timedelta(days=days_ago)).isoformat()

                session.run("""
                    MATCH (c:Customer {customer_id:$cid}),
                          (p:Product {product_id:$pid})
                    CREATE (c)-[:BOUGHT {
                        quantity:$qty,
                        last_purchase_at:$date
                    }]->(p)
                """, cid=cid, pid=prod_id, qty=qty, date=date)

    print("Neo4j graph seeded successfully!")


if __name__ == "__main__":
    seed()
