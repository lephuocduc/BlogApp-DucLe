FROM python:3.8-slim

# Set environment variables for Flask
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Install necessary packages including OpenSSL development libraries
RUN apt-get update && apt-get install -y \
    openssl \
    libssl-dev \
    gcc \
    musl-dev \
    linux-headers \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file and install dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . .

# Expose the application port
EXPOSE 5000

# Run tests before starting the application (if applicable)
RUN if [ -f app.test.py ]; then python app.test.py; fi

# Start the Flask application
CMD ["flask", "run"]