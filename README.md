# Requirements

**Docker engine** (for Linux) or **docker desktop** (for Windows), more informations are available here -> https://docs.docker.com/engine/install/
# Downloading the image or building one
* Downloading
  * On Linux, pull the image with "sudo docker pull jankierzkowski/neutrino_genie" command. 
  * On windows system first open docker desktop then in CMD/powershell run same command  "sudo docker pull jankierzkowski/neutrino_genie"
* Building an image
  * download DockerFile from this repository then you can build the image using:
    
    ```docker build -t [image_name] .```

# Instructions for opening Genie in the Docker container "neutrino1.1":

1.Running the image:
For basic Docker image configuration, run the Bash script RunDockerNeutrino.sh(Linux) or RunDockerNeutrino.sh(Windows).
IMPORTANT:Directory where the script is launched, becomes a home folder for container. All files in the home folder on your computer correspond to the /opt/Home folder in the container. 
This means you can add files to the home folder, and they will appear in the /opt/Home folder in the container, and vice versa.

2. Accessing JupyterLab:
If you have executed the script successfully, you should see some links to the JupyterLab server. Choose the link that starts with 127. and use it to access JupyterLab in your web browser.

3. Uploading files:
To upload files, click the upload arrow in the upper left corner menu of JupyterLab and select files from your computer. The chosen files will appear in the /opt/Home folder in the container.

To access the ROOT or GENIE, open a terminal in the JupyterLab's Launcher tab.
