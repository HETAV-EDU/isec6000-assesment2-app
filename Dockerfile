# Node 16 is required by the assessment
FROM node:16-bullseye-slim

# Application directory inside the container
WORKDIR /app

# Copy dependency files first to make use of Docker layer caching
COPY --chown=node:node package*.json ./

# Install only production dependencies
RUN npm ci --omit=dev

# Copy the application source
COPY --chown=node:node app.js ./

# Application listens on port 8080
EXPOSE 8080

# Security hardening: run the application as the non-root node user
USER node

CMD ["npm", "start"]
