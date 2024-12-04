# Using Node.js version 18 
FROM node:18-bullseye

# Setting working directory to / app
WORKDIR /usr/local/app

# Installing angular cli
RUN npm install -g @angular/cli    

#Copy package.json from wsu-hw-main folder
COPY angular-site/wsu-hw-ng-main/package.json  ./

#Copy package-lock.json from wsu-hw-main folder
COPY angular-site/wsu-hw-ng-main/package-lock.json ./

# Install dependencies
RUN npm install

# Copies whole  angular app from angular site to the container
COPY angular-site/wsu-hw-ng-main ./

#Starts angular when container is run from image
CMD ["ng", "serve", "--host", "0.0.0.0"]

