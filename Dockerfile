FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get install -y apache2 && apt-get clean
RUN apt-get install curl

COPY index.html /var/www/html
COPY site1.conf /etc/apache2/sites-available

RUN a2enmod rewrite
RUN a2ensite site1.conf
RUN a2enmod ssl

COPY certificate.pem /etc/ssl/certs
COPY key.pem /etc/ssl

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]