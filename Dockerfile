FROM jenkins
USER root
# Fixes some weird terminal issues such as broken clear / CTRL+L
ENV TERM=linux

# Install Ondrej repos for Ubuntu Xenial, PHP7.1, composer and selected extensions
#RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" > /etc/apt/sources.list.d/ondrej-php.list \
#    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
#    && apt-get update \
#	&& apt-get install -y software-properties-common
#RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php && \

RUN apt-get update && apt-get install apt-transport-https

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
	sh -c 'echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list'

RUN	apt-get update && \
	apt-get install -y php php7.2-xdebug php7.2-xsl php7.2-xml \
	    php7.2-zip php7.2-mbstring


USER root
ENV COMPOSER_HOME=/opt/composer

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
	php -r "unlink('composer-setup.php');" && \
	chown -R jenkins: $COMPOSER_HOME

RUN chown -R jenkins: /opt/composer/
USER jenkins

RUN composer global config minimum-stability dev && \
	composer global config prefer-stable true && \
	composer global require phpunit/phpunit squizlabs/php_codesniffer \
	    phploc/phploc pdepend/pdepend phpmd/phpmd sebastian/phpcpd \
	    mayflower/php-codebrowser


