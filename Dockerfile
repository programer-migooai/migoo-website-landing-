
FROM node:22-slim AS builder

WORKDIR /app

# Install dependencies and build the app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve the built app with a minimal server (e.g., serve)
FROM node:22-slim AS runner

WORKDIR /app

# Install a lightweight static file server

# Copy built files from builder
COPY --from=builder /app/dist ./dist

# Expose the port that "serve" uses
EXPOSE 3000

# Start the app
CMD ["npm run dev"]
