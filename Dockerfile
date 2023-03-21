# Use a lightweight node image
FROM node:alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all files to the working directory
COPY . .

# Build the Vue.js application
RUN npm run build

# Set the production environment variable
ENV NODE_ENV production

# Expose the port on which the application will run
EXPOSE 3000

# Start the application
CMD ["npm", "run", "start"]
