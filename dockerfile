# FROM davidsrmz/php8_mssql
FROM php:8-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql

RUN wget https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.5.1.1-1_amd64.apk && \
        wget https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.5.1.1-1_amd64.apk && \
        apk add --allow-untrusted msodbcsql17_17.5.1.1-1_amd64.apk && \
        apk add --allow-untrusted mssql-tools_17.5.1.1-1_amd64.apk && \
        apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS unixodbc-dev && \
        pecl install pdo_sqlsrv && \
        docker-php-ext-enable pdo_sqlsrv && \
        apk del .phpize-deps && \
        rm msodbcsql17_17.5.1.1-1_amd64.apk && \
        rm mssql-tools_17.5.1.1-1_amd64.apk