# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
# PHASE 1: Builder: Build the application

FROM node:alpine AS builder
WORKDIR "/app"
COPY package.json .
RUN npm install
# We don't need to handle volumnes for the production
# environment since we are not going to "develop" here.
COPY . .
CMD ["npm", "run", "build"]

# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
# Phase 2: Runner

# Using from again starts a new phase and stops /terminates
# the previous block / phase. 
FROM nginx:alpine
EXPOSE 80
COPY --from=builder /app/build/ /usr/share/nginx/html/
# We don't need to expliciately / specifically start
# Nginx, since the default CMD is already set implicitaly
# in the image.

# Nginx's default port is 80