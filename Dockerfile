FROM php:7.4.19-cli-alpine3.12

RUN apk add autoconf
RUN apk add build-base
RUN pecl channel-update pecl.php.net
RUN pecl install swoole-4.3.3 &&  docker-php-ext-enable swoole



RUN pecl install mongodb && docker-php-ext-enable mongodb

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

RUN apk add --update \
		$PHPIZE_DEPS \
		freetype-dev \
		git \
		libjpeg-turbo-dev \
		libpng-dev \
		libxml2-dev \
		libzip-dev \
		openssh-client \
		php7-json \
		php7-openssl \
		php7-pdo \
		php7-pdo_mysql \
		php7-session \
		php7-simplexml \
		php7-tokenizer \
		php7-xml \
		imagemagick \
		imagemagick-libs \
		imagemagick-dev \
		php7-imagick \
		php7-pcntl \
		php7-zip \
		sqlite \
	&& docker-php-ext-install iconv soap sockets exif bcmath pdo_mysql pcntl \
	&& docker-php-ext-configure gd --with-jpeg --with-freetype \
	&& docker-php-ext-install gd \
	&& docker-php-ext-install zip

WORKDIR "/var/www/"