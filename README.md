## MADE (Measuring Adaptive Distance and vaccine Efficacy using allelic barcodes)

During vaccine production, influenza viruses are unavoidably propagated in embryonated eggs. In the culture expansion, flu viruses adapt to the egg environment, a process known as passage adaptation. In our companion study, we found that egg passage adaptation is driven by repeated substitutions (i.e. convergent evolution) over 14 codons and passage adaptation often leads to highly specific alleles in egg-passaged strains. Using a statistical analysis of these sites, we develop a metric of Adaptive Distance (AD) quantifying the strength of passage adaptation and show that there is a strong negative correlation between AD of a vaccine strain and vaccine efficacy. Based on these observations and principles, we developed MADE (Measuring Adaptive Distance and vaccine Efficacy using allelic barcodes) for vaccine developers to measure the strength of passage adaptation and predict the efficacy of a vaccine strain based on its nucleotide sequence.


### Installation

In order to setup the computing environment for MADE, Docker https://www.docker.com/ is needed for subsequent installation (the version of the Docker package has to be compatible with the operational system). 
 
MADE can be directly pulled down from the github website using:

   `git clone https://github.com/chenh1gis/MADE_docker_v1.git`
 
 
### Set up the computing environment under docker

#### Step 1 : build an image from a Dockerfile

   `cat [Dockerfile] | docker build -t [a new image name] –`
   
   For example:   `cat MADE_docker/DOCKER_rmarkdown | docker build -t rmarkdown –`
   
   In this example, a new base image called rmarkdown is built.
    
#### Step 2 : run a command in a new container (a running instance of an image) & mount the current working directory to container

   `docker run -it --rm -v [current directory]:[directory in container] [an existing image name] bash`
   
   For example:   `docker run -it --rm -v $PWD/MADE_docker:/MADE_docker rmarkdown_tinytex bash`
   
   In this example, a container of the previous base images is running.
   
#### Step 3 : run MADE analysis

   *With this setup, further analysis can be executed directly in the container environment.*

#### step 4 : exit the container

   `exit`
 
### A quick start guide to docker
 
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
