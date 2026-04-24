FROM python:3.9-slim

LABEL maintainer="Khyzer"
LABEL version="1.0.0"
LABEL description="Optimized Docker image for Sakila Flask application"

WORKDIR /app

RUN useradd --create-home --shell /bin/bash appuser

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000')" || exit 1

USER appuser

CMD ["python", "app.py"]