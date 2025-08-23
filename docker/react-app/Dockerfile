# STAGE 1: Build the application
FROM node:20-alpine AS builder
WORKDIR /app
# Copy package files
COPY package.json package-lock.json* ./
# Install dependencies. Using `ci` for a deterministic install.
RUN npm ci
# Copy source code
COPY . .
# Build the application. This creates the `dist/` folder.
RUN npm run build

# STAGE 2: Serve the application
FROM nginx:alpine
# Copy the built files from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html
# The nginx:alpine image has its own CMD to start nginx.