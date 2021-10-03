# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM node:16 as build

# Create the working directory 
RUN mkdir -p /app

# Set the working directory
WORKDIR /app

#Install the angular cli
RUN npm install -g @angular/cli

# Copy package.json to app
COPY ./pokemon/package.json ./

# Install all the dependencies
RUN npm install

# Copy the angular app to app
COPY ./pokemon/ ./

# Stage 2: Generate the build of the application
RUN npm run build

# Stage 3: Serve app with nginx server

# Use official nginx image as the base image
FROM nginx:1.21.3

# Copy the build output to replace the default nginx contents.
COPY --from=build /app/dist/pokemon/ /usr/share/nginx/html

# Expose port 80
EXPOSE 80