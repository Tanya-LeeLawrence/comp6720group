# Polyglot E-Commerce System  
**COMP6720 – Data Engineering Project**  
**Author:** 
              Group 6
              
              Jariel-Jon Miller
              Patrick Anglin
              Keshawn McGrath
              Tanya-Lee Lawrence  
**Date:** December 2025  

---

## 📌 Overview
This project implements a **Polyglot Persistence Architecture** designed for a simplified E-Commerce platform.  
The system integrates four different database technologies to handle specialized workloads:


---


Each database is optimized for its role while sharing unified data models.

---

## Features

✔ ACID-compliant customer + product management in MySQL  
✔ Flexible product metadata in MongoDB (brands, sizes, gender, tags)  
✔ Graph-based recommendations using Neo4j  
✔ Real-time session cart storage in Redis  
✔ Microservices deployment via Docker Compose  
✔ Python-based data integration and ETL scripts  

---

## Project Structure

comp6720group/
│
├─ app/
│ ├─ main.py # DB connectivity test
│ ├─ seed_mongo.py # Populate MongoDB from MySQL
│ ├─ seed_neo4j.py # Graph generation for recommendations
│ ├─ redis_cart_demo.py # Redis shopping cart demonstration
│ ├─ requirements.txt # Python dependencies
│ └─ Dockerfile
│
├─ mysql/
│ └─ init.sql # Loads MySQL schema + base seed data
│
├─ mongo/
│ └─ (optional init scripts)
│
├─ neo4j/
│ └─ (optional CSV import files)
│
├─ redis/
│ └─ (not required)
│
└─ docker-compose.yml


---

## Requirements

- Docker Desktop
- WSL2 (Windows) or Linux/macOS
- Internet access to pull images initially

---

##  Run Instructions

1️. Build and start services  

docker compose up -d --build


2.Verify running containers

docker ps --format "{{.Names}}

Expect:

app_service
mysql_db
mongo_db
neo4j_db
redis_db

3. Run MongoDB ETL seed
docker exec -it app_service python3 seed_mongo.py


4. Run Neo4j graph creation
docker exec -it app_service python3 seed_neo4j.py

5. Test Redis cart
docker exec it app_service python3 redis_cart_demo.py


Example Queries

1. Neo4j

MATCH (c:Customer)-[:BOUGHT]->(p:Product)
RETURN p.name AS product, COUNT(*) AS purchase_count
ORDER BY purchase_count DESC LIMIT 10;

2. MongoDB 

 docker exec -it mongo_db mongosh --eval "db = db.getSiblingDB('ecommerce'); db.products.countDocuments()"

 3. MYSQL

 docker exec -it mysql_db mysql -u appuser -papppass -e "DESCRIBE ecommerce.customers;"

 4. Redis

 




