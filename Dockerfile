FROM nginx:latest
WORKDIR /app

COPY /home/ansible/docker_ci_cd/index.html /usr/share/nginx/html/
