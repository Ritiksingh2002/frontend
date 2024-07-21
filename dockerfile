# Use a base Node.js image
FROM node:14-alpine as build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build Vue.js application
RUN npm run build

# Stage 2 - Serve the production build using a simple Node.js server
FROM node:14-alpine

# Set working directory
WORKDIR /app

# Copy built files from the build stage
COPY --from=build /app/dist /app/dist

# Install serve globally (optional, if you want to use serve to serve the static files)
RUN npm install -g serve

# Expose port 80 (optional, depending on your deployment environment)
EXPOSE 80

# Command to serve the built Vue.js application with serve
CMD ["serve", "-s", "dist"]
