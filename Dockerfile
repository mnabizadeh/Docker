FROM ubuntu
#MAINTAINER is used to display the name oand email details of build owner
#SHELL used to set the default shell
#COPY used to transfer the local file to Docker container

ENV DEBIAN_FRONTEND=non-interactive
# Install dependencies
RUN apt-get update -y
RUN apt-get install -y git curl apache2 php libapache2-mod-php php-mysql

# Install app
RUN rm -rf /var/www/html/*

#ADD(local and additiona urls) and COPY(only local files) are used in a similar way
ADD src /var/www/html/

# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www/html
ENV APACHE_RUN_DIR /var/www/html
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2


EXPOSE 80

CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
