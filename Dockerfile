# Use official Python base image
FROM python:3.11-slim

# Set working directory inside the container
WORKDIR /app

# Install system dependencies (if any needed for psycopg2)
RUN apt-get update && \
    apt-get install -y build-essential libpq-dev && \
    apt-get clean

# Copy requirements.txt first (for caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy entire project
COPY . .

# Default command to run the application
CMD ["python", "app.py"]
