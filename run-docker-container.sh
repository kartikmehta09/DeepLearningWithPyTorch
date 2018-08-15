#!/bin/bash
xhost +local:root​

nvidia-docker run -it \
   -p 8888:8888 \
   --env="DISPLAY" \
   --env="QT_X11_NO_MITSHM=1" \
   --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
   -v $(pwd):/home/project \
   --ipc=host \
   --name DL-With-PyTorch \
   ksjdk/deeplearning:pytorch04-cu80-jupyter \
   bash

xhost -local:root

# jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/home/project'
# for PyTorch --ipc=host
