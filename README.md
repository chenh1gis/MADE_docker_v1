## MADE (Measuring Adaptive Distance and vaccine Efficacy using allelic barcodes)

MADE is a computational package calibrating the strength of passage adaptation happened in a given isolate (strain). The strength of the passage adaptation is defined as the Adaptive Distance (AD) between the center of the major cluster of all isolates in the database and the strain of interest in the principle component analysis (PCA) (See Chen et al for details). Since adaptive distance is found to be negatively correlated with the vaccine efficacy, MADE will also predict potential vaccine efficacy of the input isolate using its nucleotide sequence. [link to example report]


### Installation

Docker [https://www.docker.com/] is compulsory to be installed before the global environmental setup.
Please be very careful about the version of docker which should be compatible with your computing platform.
 
MADE can be directly pulled down from github website:

   `git clone https://github.com/chenh1gis/MADE_docker_v1.git`
 
 
### Set up environment under docker

#### Step1: build an image from a Dockerfile

   `cat [Dockerfile] | docker build -t [a new image name] –`
   
   For example:   `cat MADE_docker/DOCKER_rmarkdown_tinytex | docker build -t rmarkdown_tinytex –`
 
#### Step2: run a command in a new container & mount the current working directory to container

   `docker run -it --rm -v [current directory]:[directory in container] [an existing image name] bash`
   
   For example:   `docker run -it --rm -v $PWD/MADE_docker:/MADE_docker rmarkdown_tinytex bash`

#### Step3: run MADE analysis

   *Hereby, please note that any analysis is able to be performed directly in the running container once the environmental setup is finished.*

#### step4: exit the container

   `exit`
 
 
### Docker command notes
 
* Detach

   `Ctrl+p or Ctrl+q`
 
* Re-attach to a running container

   `docker attach [container name / container ID]`
 
* List all containers or images

   `docker ps -a`
   `docker images`
 
* Delete a container or image:

   `docker rm [container name / container ID]`
   `docker rmi [image ID / image_name:image_tag]`
 
 
### License
This project is licensed under the GNU GPLv3 License - see the LICENSE file for details.
