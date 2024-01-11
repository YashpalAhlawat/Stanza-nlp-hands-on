# Use an official Python runtime as a parent image
FROM python:3.8-slim
# Set the working directory in the container
WORKDIR /app

# Create a non-root user
RUN useradd -ms /bin/bash myuser


# Copy the current directory contents into the container
COPY . /app



# Grant execute permissions to the script
RUN chmod +x /app/*


# Install any needed packages specified in requirements.txt and required packages for stanza, gevent and gunicorn
RUN apt-get update && apt-get install -y build-essential python3-dev libev-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && python -c "import stanza; stanza.download('en', processors='tokenize,pos,lemma')" \
    && pip install gevent gunicorn


# Expose the port the app runs on
EXPOSE 8080

# Switch to the non-root user
USER myuser

# Run the script when the container launches
CMD ["sh","run_app.sh"]

