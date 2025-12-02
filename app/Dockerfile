FROM python:3.12

WORKDIR /app

# Copy requirement file first for caching
COPY requirements.txt .

RUN pip install -r requirements.txt

# Copy rest of app code
COPY . .

CMD ["python3", "main.py"]
