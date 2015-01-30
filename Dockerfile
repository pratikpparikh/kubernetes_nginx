FROM debian:wheezy

MAINTAINER ryan.richard@rackspace.com

EXPOSE 443

#Install Nginx and stop it from running
RUN apt-get update && apt-get install openssl nginx apache2-utils -qq -y && rm -rf /var/lib/apt/lists/*
RUN service nginx stop

# Add our Conf files and disable the default site
ADD nginx.conf /etc/nginx/
ADD kubernetes-site /etc/nginx/sites-enabled/
RUN rm -f /etc/nginx/sites-enabled/default

# Create SSL Certificates at build time
#ADD make-ca-cert.sh /root/
ADD make-cert.sh /root/
ADD kub-ssl.cnf /root/
RUN chmod 755 /root/make-cert.sh
RUN /root/make-cert.sh

# Add file with http auth username/password and run the script to convert this to htpasswd file
ADD .kubernetes_auth /root/.kubernetes_auth
ADD make-htpasswd.sh /root/
RUN /root/make-htpasswd.sh

ENTRYPOINT nginx
CMD []
