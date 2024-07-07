# Use an official Node.js image as a base
FROM node:lts-alpine3.17
# Set the working directory to /app
WORKDIR /app
# Copy the package.json file
COPY package*.json ./
# Install dependencies
RUN npm install
# Copy the remaining files
COPY . .
# Expose the port that the app will use
EXPOSE 3000
# Run the command to start the app
CMD ["node", "server.js"]
