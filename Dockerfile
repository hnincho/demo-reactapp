# Stage 1: Build React App
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# Copy package.json and install dependencies
COPY package.json package-lock.json* ./
RUN npm install --silent

# Copy all source files and build
COPY . ./
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Remove default Nginx config
RUN rm -rf /etc/nginx/conf.d

# Copy custom Nginx config
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Copy React build from builder
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

