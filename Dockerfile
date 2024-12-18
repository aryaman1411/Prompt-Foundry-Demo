Creating a Dockerfile and necessary scripts to containerize a full-stack application can vary greatly depending on the specific technologies used in your stack. However, I'll provide a general example using a Node.js backend and a React frontend.

First, let's create a Dockerfile for the backend:

```Dockerfile
# Dockerfile for Node.js backend

# Use official Node.js runtime as a parent image
FROM node:14

# Set the working directory in the container to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the current directory contents into the container at /app
COPY . .

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run the app when the container launches
CMD ["npm", "start"]
```

Next, let's create a Dockerfile for the React frontend:

```Dockerfile
# Dockerfile for React frontend

# Use official Node.js runtime as a parent image
FROM node:14

# Set the working directory in the container to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the current directory contents into the container at /app
COPY . .

# Build the app
RUN npm run build

# Use Nginx to serve the build folder
FROM nginx:1.17.1-alpine

# Copy the build folder from react build stage
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
```

Finally, we can use Docker Compose to manage these services together. Here's a simple `docker-compose.yml` file:

```yaml
version: '3'
services:
  backend:
    build: ./backend
    ports:
      - '8080:8080'
  frontend:
    build: ./frontend
    ports:
      - '80:80'
```

This setup assumes that your project structure looks something like this:

```
/myapp
  /backend
    Dockerfile
    package.json
    (other backend files)
  /frontend
    Dockerfile
    package.json
    (other frontend files)
  docker-compose.yml
```

To build and run the services, you would use the command `docker-compose up --build`.