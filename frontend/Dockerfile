# Use a Node.js 16 base image
FROM node:16

# Create a directory for the app
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the app files
COPY . .

# Build the app with Vite
RUN npm run build

# Use a lightweight Node.js image for production
FROM node:16-alpine

# Create a directory for the app
WORKDIR /app

# Copy the built app from the previous stage
COPY --from=0 /app/dist ./dist

# Install a static file server
RUN npm install -g serve

# Set the command to serve the app
CMD ["serve", "-s", "dist"]
