FROM ubuntu:14.04

MAINTAINER ryan.richard@rackspace.com

EXPOSE 443

RUN apt-get update
RUN apt-get install openssl nginx apache2-utils -qq -y
RUN service nginx stop

ADD nginx.conf /etc/nginx/
ADD kubernetes-site /etc/nginx/sites-enabled/
#ADD make-ca-cert.sh /root/
ADD make-cert.sh /root/
ADD .kubernetes_auth /root/.kubernetes_auth
ADD make-htpasswd.sh /root/
RUN rm -f /etc/nginx/sites-enabled/default
RUN /root/make-htpasswd.sh

RUN chmod 755 /root/make-cert.sh
RUN /root/make-cert.sh

ENTRYPOINT nginx
CMD []
