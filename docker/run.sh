xhost +
docker run \
    --rm \
    --privileged \
    -e DISPLAY \
    --gpus=all \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -tid \
    -v $PWD/../:/home/DBNet/ \
    -v $PWD/../../../datasets/:/home/datasets/ \
    --name db_det \
    -v /usr/lib/nvidia:/usr/lib/nvidia \
    -v /usr/lib32/nvidia:/usr/lib32/nvidia \
    db:latest
