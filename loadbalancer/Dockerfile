FROM centos:latest

RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y nginx

RUN rm -v /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/

EXPOSE 80

# CMD systemctl start nginx
CMD ["nginx", "-g", "daemon off;"]
