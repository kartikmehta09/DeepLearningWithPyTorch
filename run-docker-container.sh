#!/bin/bash

set -e

# Settings from environment
CONTAINER_NAME="DLWithPyTorch"

# Check if container exist
if [ "$(docker ps -a | grep ${CONTAINER_NAME})" ]; then
	if [ "$(docker ps | grep ${CONTAINER_NAME})" ]; then
		echo "Attaching to running container...press ENTER"
  		nvidia-docker exec -it ${CONTAINER_NAME} bash $@	
	else
	        echo "Restart container..."
	    	nvidia-docker restart ${CONTAINER_NAME}

	    	echo "Attach container...press ENTER"
	    	nvidia-docker attach ${CONTAINER_NAME}		
	fi
else
	# Create new container
	echo "Create new container..."
	xhost +local:root​

	nvidia-docker run -it \
	   -p 8888:8888 \
	   --env="DISPLAY" \
	   --env="QT_X11_NO_MITSHM=1" \
	   --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	   -v $PWD:/home/project \
	   --ipc=host \
	   --name ${CONTAINER_NAME} \
	   ksjdk/deeplearning:cu90-pt040-py36 \
	   bash

	xhost -local:root
fi


# jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/home/project'
# for PyTorch --ipc=host
