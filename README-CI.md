# CI Project Overview

- In this project we are trying to containerize an application in our case an angular site in docker. We are packaging the app and its dependencies into a container. The container once finished will be able to run across different enviorments and will be much lighter weight. We are doing this so that the app can run in its own isolated container, regardless of operating systems, if you have docker installed you will be able to run the app. It is also much more efficent and scaleable, using less resources and being able to create  new containers if your load increases. Using tools like docker and dockerhub to find and share docker container images.

# Containerizing your Application

- In order to install docker on windows, you have to go to dockers website and download docker desktop for windows machines. 
- To build a container without an image, you would need to pull the Node.js image in our context its node:18-bullseye.
Then you will need to start a new container using the Node.js image you pulled, `docker run` creates and runs a new container, --it will take you inside the container and --name specifies container name. `docker run --it --name angular-site`
- You will also need to install Angular CLI inside the container with `npm install -g @angular/cli` and dependencies with `npm install`, then run the app with `ng serve --host 0.0.0.0` which will run the angular app and bind to any IP.
- In the docker file there are instruction that tell docker what to do, first the Base Image, ours being node:18-bullseye, then setting the working directory for the container `/app`, Copy files which copies the apps source code and configuration files from the host to the container `COPY . .`, Expose port which is optionall, will expose port 4200 for the angular app, and then the RUN command will set `ng serve --host 0.0.0.0` as the default to start the app.
- If you want to build an image from the repo, you will need to go to the repo directory that had the dockerfile `cd [path to repo]` then build the image with `docker build -t angular-site` 
- ToDO
- If you want to view the app running in the container you can open a web browser and go to `http://localhost:4200` if rynning locally 

[DockerDoc Used](https://docs.docker.com/reference/cli/docker/container/run/#example-join-another-containers-pid-namespace)


[DockerDoc Used](https://docs.docker.com/reference/cli/docker/)

# Working with DockerHub 

- If you want to create a public repo in DockerHub, you will need to first make an account on DockerHub, once logged in go to Repositories and click "Create Repository", fill out the info with the repo name,then set to public and create.

- To authenticate DockerHub with CLI, use `docker login -u [DockerHub username]` and then when prompted authenticate your password

[Docker Doc Used](https://docs.docker.com/reference/cli/docker/login/)

- Once you want to push the container image to DockerHub you will have to do `docker push [DockerHub Username]/angular-site`

- Link to DockerHub repo[DockerHub repo](https://hub.docker.com/repository/docker/ethanschultz2/schultz-ceg3120/general)
