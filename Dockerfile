FROM ubuntu:14.10

MAINTAINER ryan.richard@rackspace.com

EXPOSE 443

RUN apt-get update
RUN apt-get install openssl nginx -qq -y
RUN service nginx stop

ADD nginx.conf /etc/nginx/
ADD kubernetes-site /etc/nginx/sites-enabled/
#ADD make-ca-cert.sh /root/
ADD make-cert.sh /root/

RUN chmod 755 /root/make-cert.sh
RUN /root/make-cert.sh

ENTRYPOINT nginx
CMD []