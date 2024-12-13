# CD Project Overview


## How to generate and push a tag in git
- If you want to generate a tag in git you need to use `git tag` since we are using semantic versioning for this project it would look like `git tag v1.0.0` where the first number following the v (version) is a major version, the second number is a minor version, and the third is a patch. After taging you need to push to the repo with your specific tag you created, with `git push origin v1.0.0` or whatever semantic versioning tag you specified.

## Behavior of Github Workflows
- My updated github workflow is triggered when a `git tag` matches our semantic versioning pattern of `v*.*.*` is pushed to the repository.
- When triggered it uses the `docker/metadata-action` to generate Docker image tags based on the versioning that was pushed. (Prior to this versioning trigger the workflow would push a Docker image to Docker hub with tag of "latest" now it gets pushed to DockerHub with the version specified by the git tag in `v*.*.*` format)
- It will push the image with the latest tag to my DockerHub repository.
- Then it will `Checkout`, cloning the repo to the actions runner making my files available.
- Sets up `QEMU` for emulator support to build on mutiple platforms.
- Sets up `Docker Buildx` which creates and boots a Docker buildx enviornment that allows building and pushing multi platform docker images.
- Then it will log into DockerHub using my two github secrets that contain my username and private access token (password).
- Finally it will then build the image in the context of my repos root directory and push the image to  DockerHub with the generated tags based on the semantic versioning information you specified.As well as labeling the Docker image to help organize the images and differentiate between the images, containers etc...
- In summary our workflow does all of the things in our previous CI workflow, but key changes made were adding semantic versioning so the workflow is triggered by a `git tag v*.*.*` and push. Then is tagged and labeled when the image is oushed to DockerHub to differentiate between versions. 


[DockerHub Repo Link](https://hub.docker.com/repository/docker/ethanschultz2/schultz-ceg3120/general)


### Part 2 - Deployment

## Instance Information
- Using Ubuntu 24.04.1 LTS 
- Instances Public IP is 54.234.232.100
## How to install Docker on Ubuntu Instance
- In order to install Docker on an ubuntu instance you will first need to update with `sudo apt-get update`
- After updating you can install Docker with `sudo apt-get install docker.io -y` this should install Docker onto your system and you can `sudo systemctl start docker` to start Dockers service.
- To check if Docker was successfully installed and started you can `sudo docker run hello-world` which should prompt you with a welcome message to ensure it was installed. 

# Bash Script
- The purpose of this bash script is to automate the process of updating a docker container and running it.
- It will first stop the container `birdsite` in my case and pull the latest version of the docker image from DockerHub.
- Then starts a new container and runs the latest version of it, keeping a running up to date version of the container.
- The location of my bash script is `/home/ubuntu/myScript`

##Steps to install webhooks on instance
- First ssh into your instance, once youre in you should `sudo apt update` barring that you need to clone `adnanh`'s repo in order for you to have on your system
- Then you will need to make it executable with `sudo chmod +x [path to webhook]`
- Once you have it installed on your system and made it executable you will need to make a `hooks.json` file that will configure what your webhook(s) will do.
- You will in your security groups for instance also need to allow for ports 80(HTTP) and 9000(Port that webhook listen to) to be open.
- [Bash Script](https://github.com/WSU-kduncan/f24cicd-ethanschultz2/blob/main/deployment/myScript)

## Purpose of installing webhook to instance
- We installed webhook in order to recieve HTTP requests and be able to trigger an action of our choice. In our case it will trigger our bash script that updates to latest version and runs that version.
- Our other trigger `jazz` will trigger when pushed with latest tagged.
- Webhook task definition file is located at `/home/ubuntu/hooks.json`
- [Hooks Def File](https://github.com/WSU-kduncan/f24cicd-ethanschultz2/blob/main/deployment/hooks.json)

## How to start webhook listenting 
- Once you have configured your webhook to do what you want you can use this `webhook -hooks hooks.json -verbose` if you have a file named hooks.json and it will start listening on port 9000.

## How to test that the listener is successful
- You should have to first make a version change and `git tag` with a version and push to that origin and main to keep up to date for it to trigger.
- When you first run your webhooks command it should log to you different things that are set up you should look for `attempted to load hooks from hooks.json` and if it says `found (2) hooks in file` and in my context they are `birdsite` and `jazz` it will say that its serving hooks at ` http://0.0.0.0:9000/hooks/{id}` you want to put you public ip in for the `0.0.0.0` and `jazz or birdsite` for the `{id}`.
- Once you put that into your browser you should look back as logs should be coming in you should mainly be looking for the HTTP request, which hook is being triggered and the execution of that command. If there are any errors that happen in the logs it should tell you where and what is going wrong.
