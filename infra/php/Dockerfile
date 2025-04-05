FROM php:8.2-fpm-buster
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

# ユーザー作成
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID dev && \
  useradd -u $UID -g dev -m dev

ENV COMPOSER_ALLOW_SUPERUSER=1 \
  COMPOSER_HOME=/composer

COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# パッケージのインストール
RUN apt-get update && apt-get install -y \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libzip-dev \
  libicu-dev \
  libwebp-dev \
  && rm -rf /var/lib/apt/lists/*

# GD拡張のインストール
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
  && docker-php-ext-install gd

# その他の拡張をインストール
RUN docker-php-ext-install -j$(nproc) \
  pdo_mysql \
  bcmath \
  opcache \
  intl \
  zip

# Redisのインストール
RUN pecl install redis && docker-php-ext-enable redis

# Xdebugのインストール（rootユーザーで実行）
RUN pecl channel-update pecl.php.net && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug

COPY ./php.ini /usr/local/etc/php/php.ini

# 作業ディレクトリを作成してから権限を設定
WORKDIR /work
RUN chown -R dev:dev /work

# 最後にユーザーを切り替え
USER dev