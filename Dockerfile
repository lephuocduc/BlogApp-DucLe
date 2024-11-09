FROM python:3.8-alpine

# Set environment variables for Flask
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Install necessary packages including OpenSSL development libraries
RUN apk add --no-cache openssl-dev gcc musl-dev linux-headers

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