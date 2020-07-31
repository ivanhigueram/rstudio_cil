# Singularity RStudio Server Container

This repository will guide you on how to run Rstudio using Singularity (because
Docker is not available in HPC systems). Singularity allow us to have
a controlled environment to install R and its libraries. This repo is using the
Rocker container repository, and particularly the geospatial container to fit
the needs of the projects involving CIL. 


# Use

Install and run infrastructure:

1. Clone the repoo
2. Go to the repo folder: `cd rstudio_cil`
3. Run `./bastion.sh all` 

 Wait for Singularity to install RStudio Server and the image dependencies. Once
 that's done you can open a SSH tunnel to the `8787` port (check the **Some
 Tricks** section). 

4. Go to your local machine explorer and go to `localhost:8787`. 
5. Login into the RStudio Server using your username (the one you use normally
   to login) and the password `PULANSKIATNIGHT`. 

6. Do R! 


# Some tricks

You need a SSH tunnel to access to RStudioo Server. You can use a simple
approach: `ssh -Nf -L 8787:localhost:8787 <user>@*.gspp.berkeley.edu`, or even
better, you can set a tunnel from your `~/.ssh/config` file: 

``` 
Host sacagawea
    HostName sacagawea.gspp.berkeley.edu
    User <your user>
    IdentityFile <path to key -- if configured>
    LocalForward 8787 localhost:8787
```

Here `LocalForward` is setting the tunnel without having to run another SSH connection. 
