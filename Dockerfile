# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set environment variables for NLP pipeline and language
ENV NLP_PIPELINE "default"
ENV LANGUAGE "english"

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 5000

# Define environment variable for Flask
ENV FLASK_APP=app.py

# Run app.py when the container launches
CMD ["flask", "run", "--host=0.0.0.0"]

