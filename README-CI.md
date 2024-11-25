# CI Project Overview

- In this project we are trying to containerize an application in our case an angular site in docker. We are packaging the app and its dependencies into a container. The container once finished will be able to run across different enviorments and will be much lighter weight. We are doing this so that the app can run in its own isolated container, regardless of operating systems, if you have docker installed you will be able to run the app. It is also much more efficent and scaleable, using less resources and being able to create  new containers if your load increases. Using tools like docker to build and run our application and dockerhub to store/share our images. 
i
# Containerizing your Application

- In order to install docker on windows, you have to go to dockers website and download docker desktop for windows machines.
 
- To build a container without an image, you would need to pull the Node.js image in our context its node:18-bullseye.Then you will need to start a new container using the Node.js image you pulled, `docker run` creates and runs a new container, --it will take you inside the container and --name specifies container name. `docker run --it --name angular-site node:18-bullseye` [DockerDoc Used](https://docs.docker.com/reference/cli/docker/container/run/#example-join-another-containers-pid-namespace)

- You will also need to install Angular CLI inside the container with `sudo npm install -g @angular/cli` then you can run the app from the project folder with  `ng serve --host 0.0.0.0` which will run the angular app and bind to any IP. I tried to run the with just the above commands but got an error that some node packages may not be installed, so dont forget to `npm install` as well to download depencdencies and packages. 

- In the docker file there are instruction that tell docker what to do in order to create a container image.First the Base Image our build extends, ours is node:18-bullseye using `FROM node:18-bullseye`, then setting the working directory and where files will be copied and commands will be exucuted. `WORKDIR /usr/local /app`, Copy files which Copy the current directory to container image using `COPY . .`, Expose port which is optionall, will indicate which port the image will expose, and then the RUN command will tell the builder to run this command, `RUN npm install -g @angular/cl`  which will install angular and packages and dependencies needed. Finally, the CMD instruction which sets the default command a container using this image will run, in our case `ng serve --host 0.0.0.0` using `CMD ["ng", "serve", "--host", "0.0.0.0"]`
- 
[Doceker Doc Used for DockerFile](https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/)

- If you want to build an image from the repo, you will need to go to the repo directory that had the dockerfile `cd [path to repo]` then build the image with `docker build -t [your image name] .` this will tag your image during the build with -t

- In order to run the container from the image that we build with the Docker file, we use ` docker run -d -p 4200:4200 angular-site` since we are using `ng serve --host 0.0.0.0` its listening on all ports inside the container, and angluar by default uses port 4200 to listen, so -p 4200:4200 will allow incoming traffic to port 4200 on my host to be routed to port 4200 inside the container, and -d used for detach mode starting container as background process

[Docker run Doc Used](https://docs.docker.com/reference/cli/docker/container/run/)

- If you want to view the app running in the container you can open a web browser and go to `http://localhost:4200`

# Working with DockerHub 

- If you want to create a public repo in DockerHub, you will need to first make an account on DockerHub, once logged in go to Repositories and click "Create Repository", fill out the info with the repo name,then set to public and create.

- To authenticate DockerHub with CLI, use `docker login -u [DockerHub username]` and then when prompted authenticate your password

[Docker Doc Used](https://docs.docker.com/reference/cli/docker/login/)

- Once you want to push the container image to DockerHub you will have to do `docker push [DockerHub Username]/angular-site` which will push your container image to DockerHub

- Link to DockerHub repo [DockerHub repo](https://hub.docker.com/repository/docker/ethanschultz2/schultz-ceg3120/general
) 



# Part 2 - Github Action and DockerHub
