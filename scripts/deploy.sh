#!/bin/bash
# this script should be located in the home folder ~

random=$(echo $RANDOM | date | md5sum | head -c 32)
random="first_page_$random"

running_id=$(sudo docker ps -a --filter "status=running" -q)
echo "Running ID: $running_id"

cd /home/bashkim

# if there are no containers
if [ -z "${running_id}" ]
then
    echo "There weren't any Docker container!"
    sudo docker build -f docker_ci_cd/Dockerfile -t first_page:atest .
    sudo docker run --name "$random" -d -p 8080:80 first_page:latest 

    echo "Docker was created successfuly!"
    exit 0
fi

running_port=$(sudo docker port $running_id | grep -oE '[0-9]+$' | head -n 1)
echo "Running Port: $running_port"
echo "Random string: $random"

if [ $running_port = 8080 ]
then
    sudo docker build -f docker_ci_cd/Dockerfile -t first_page:latest .
    sudo docker run --name "$random" -d -p 8081:80 first_page:latest
else
    sudo docker build -f docker_ci_cd/Dockerfile -t first_page:latest .
    sudo docker run --name "$random" -d -p 8080:80 first_page:latest
fi

sudo docker stop $running_id
sudo docker container prune -f
sudo docker image prune -a -f

exit 0
