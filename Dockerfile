FROM nginx:latest
WORKDIR /app

COPY docker_ci_cd/index.html /usr/share/nginx/html/
