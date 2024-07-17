# Building and Running Flask Application with Docker

## Dockerfile

Create a Dockerfile in the root directory of your project with the following content:

```dockerfile
# Use the official Python image
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy and install requirements
COPY requirements.txt /app
RUN apt-get update && apt-get install -y build-essential
RUN pip install -r requirements.txt

# Copy the entire project to the working directory
COPY . /app

# Set environment variables
ENV FLASK_APP=core/server.py
ENV GUNICORN_PORT=5000

# Run database migrations
RUN flask db upgrade -d core/migrations/

# Command to run the application using Gunicorn
CMD ["gunicorn", "-c", "gunicorn_config.py", "core.server:app"]
```
## docker-compose.yml

Create a docker-compose.yml file in the root directory of your project:

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - .:/app
```

## Building and Running the Application

1. **Build the Docker Image:**

	Open a terminal, navigate to your project directory containing the Dockerfile and docker-compose.yml, and run:

```bash
	docker compose build
```

	This command builds the Docker image based on the Dockerfile and installs dependencies defined in requirements.txt.

2. **Run the Docker Container:**

	After the build completes successfully, start the Docker container by running:

```bash
docker compose up
```

	This command starts your Flask application inside a Docker container using Gunicorn. It binds port 5000 of the container to port 5000 on your host machine, allowing you to access the application.

3. **Accessing the Application:**

	Open a web browser and go to **`http://localhost:5000`** to access your Flask application running inside the Docker container.

### Notes:

- **Dockerfile Details:**

	- Installs system dependencies (**`build-essential`**).
	- Copies the project files into the container.
	- Sets environment variables (**`FLASK_APP`** and **`GUNICORN_PORT`**).
	- Runs Flask database migrations (**`flask db upgrade`**).

- **docker-compose.yml Details:**

	- Defines a service named **`web`** using the Dockerfile in the current directory (**`build: .`**).
	- Maps port 5000 of the host to port 5000 of the container (**`ports`**).
	- Mounts the current directory (your project directory) into the **`/app`** directory of the container (**`volumes`**).

This setup allows you to easily build and run your Flask application with Docker, ensuring portability and consistency across different environments.
