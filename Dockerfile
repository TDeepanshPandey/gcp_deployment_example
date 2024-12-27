# Use the official Node.js image as the base image
FROM node:alpine3.20

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install dependencies (none for this simple example, but it's a good practice)
RUN npm install

# Copy the application code into the container
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the app
CMD ["node", "index.js"]
