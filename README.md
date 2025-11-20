📘 Polyglot E-Commerce System — Group Project (COMP6720)

This project implements a Polyglot Persistence Architecture using four different database technologies:

PostgreSQL — Relational, transactional data

MongoDB — Document-based product catalog

Neo4j — Graph-based recommendation system

Redis — In-memory key-value caching layer (shopping cart, sessions, popularity scores)

🐳 Running the Project (Docker Setup)

Ensure Docker and Docker Compose are installed.

1. Start all databases

In the project folder, run:

docker compose up -d


2. Install Python dependencies
pip install -r requirements.txt

3. Run the demo application
python app.py

🧪 Testing Each Database
Redis CLI
docker exec -it redisdb redis-cli

Mongo Shell
docker exec -it mongodb mongosh

PostgreSQL Shell
docker exec -it pgdb psql -U admin -d ecommerce

Neo4j Browser

👉 http://localhost:7474

Login: neo4j / password
