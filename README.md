## MADE (Measuring Adaptive Distance and vaccine Efficacy using allelic barcodes)

During traditional egg vaccine production, influenza viruses are unavoidably propagated in embryonated eggs. And in this culture expansion, flu viruses adapt to the egg environment, a process known as passage adaptation. In our companion study, we found that egg passage adaptation is driven by repeated substitutions (i.e. convergent evolution) over a set of codons, which subsequently leads to highly enriched specific alleles in egg-passaged strains. Using a statistical analysis of these sites, we develop a metric of Adaptive Distance (AD) quantifying the strength of passage adaptation and show that there is a strong negative correlation between Adaptive Distance (AD) of a vaccine strain and Vaccine Efficacy (VE). 

Based on these observations and principles, we have developed a tool called MADE (Measuring Adaptive Distance and vaccine Efficacy using allelic barcodes). Through the application of a machine learning method, the passage history of Candidate Vaccine Viruses (CVVs) will be examined and simultaneously the adaptive Vaccine Efficacy (VEad) will be predicted. We hope that this tool will serve as a prescreening tool for WHO and vaccine developers with the aim to select the better vaccine strain devoid of egg passage adaptation and achieve a more optimistic vaccine performance. 


### Installation

In order to setup the computing environment for MADE, Docker https://www.docker.com/ is needed for subsequent installation (the version of the Docker package has to be compatible with the operational system). 
 
MADE can be directly download from the github website using:

   `git clone https://github.com/chenh1gis/MADE_docker_v1.git`
 
 
 
### Set up the computing environment under docker

#### Step 1 : build an image from a Dockerfile

   `cat [Dockerfile] | docker build -t [a new image name] -`
   
   For example:   `cat MADE_docker_v1/DOCKER_rmarkdown | docker build -t rmarkdown -`
   
   In this example, a new base image called **rmarkdown** is built.
    
#### Step 2 : run a command in a new container (a running instance of an image) & mount the current working directory to container

   `docker run -it --rm -v [current directory]:[directory in container] [an existing image name] bash`
   
   For example:   `docker run -it --rm -v $PWD/MADE_docker_v1:/MADE_docker_v1 rmarkdown bash`
   
   In this example, a container of the previous base images is running.
   
#### Step 3 : run MADE analysis

   *With this setup, further analysis can be executed directly in the container environment.*

#### step 4 : exit the container

   `exit`
 

### A quick start guide to docker
 
* Detach

   `Ctrl+q`
 
* Re-attach to an up-running container

   `docker attach [container name / container ID]`
 
* List all containers or images

   `docker ps -a`
   
   `docker images`
 
* Delete a container or image:

   `docker rm [container name / container ID]`
   `docker rmi [image ID / image_name:image_tag]`
 
 
 
### License
This project is licensed under the GNU GPLv3 License - see the LICENSE file for details.
