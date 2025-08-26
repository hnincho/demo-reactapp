# Stage 1: Builder 
FROM node:20-alpine as builder

WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# Install dependencies
COPY package.json /usr/src/app/package.json
RUN npm install --silent

# Copy source and build
COPY . /usr/src/app
RUN npm run build

# Stage 2: Runtime (Nginx)
FROM nginx:alpine

# Remove default config and add custom
RUN rm -rf /etc/nginx/conf.d
COPY conf /etc/nginx

# Copy build output (React default = build/)
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
