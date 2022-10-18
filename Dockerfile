FROM ubuntu:20.04
MAINTAINER somesh
LABEL "about"="A label for jenkins demo"
RUN apt update && apt install -y nginx && service nginx start
WORKDIR /sml
COPY index.html .
RUN cat index.html > /var/www/html/index.nginx-debian.html
CMD ["bash"]
EXPOSE 8081