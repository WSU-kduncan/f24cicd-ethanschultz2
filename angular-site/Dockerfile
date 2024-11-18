# Using Node.js version 18 

FROM node:18-bullseye

# Setting working directory to / app
WORKDIR /usr/local /app

# Installing angular cli
RUN npm install -g @angular/cli    

# Copy the current directory to /app
COPY . .

# Starts angular when container is run from image
CMD ["ng", "serve", "--host", "0.0.0.0"]

