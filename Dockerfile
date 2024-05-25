FROM php:7.3-cli

RUN  apt update && apt-get install -y libcurl4-openssl-dev pkg-config libssl-dev

RUN apt-get install autoconf
#RUN apt-get install build-base
RUN pecl channel-update pecl.php.net
RUN pecl install swoole-4.3.3 &&  docker-php-ext-enable swoole



RUN pecl install mongodb-1.6.1 && docker-php-ext-enable mongodb

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

RUN apt-get clean all && apt-get update && apt-get install -y --no-install-recommends --allow-downgrades \
        git \
        zlib1g-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo pdo_mysql mysqli \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install calendar

RUN curl -sS https://getcomposer.org/installer | php -- \
--install-dir=/usr/bin --filename=composer \
    && chmod a+x /usr/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

WORKDIR "/var/www/"