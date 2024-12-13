# CD Project Overview
test more again hello

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

## Purpose
