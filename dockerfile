# Stage 1: Build the Vue.js application
FROM node:14 AS build

WORKDIR /app

COPY package*.json ./

# Install dependencies
RUN npm install

COPY . .

# Build the Vue.js application
RUN npm run build

# Stage 2: Serve the Vue.js application using Nginx
FROM nginx:1.21-alpine

COPY --from=build /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
