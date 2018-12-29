FROM node:10-stretch
MAINTAINER Huiren Woo <giantcrabby@gmail.com>
LABEL maintainer="Huiren Woo <giantcrabby@gmail.com>"

RUN apt-get update \
    && apt-get --yes --force-yes install apt-transport-https

RUN wget 'https://cli.run.pivotal.io/stable?release=debian64&source=github' -O cf_cli.deb \
    && dpkg -i ./cf_cli.deb \
    && apt-get --yes --force-yes install -f \
    && cf --version

RUN cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org \
    && cf install-plugin blue-green-deploy -r CF-Community -f

RUN cf install-plugin https://github.com/odlp/antifreeze/releases/download/v0.4.0/antifreeze-linux

RUN apt-get --yes --force-yes install nginx

RUN printf "server { \n\
                location / { \n\
                    try_files $uri $uri/ /index.html; \n\
                } \n\
            }\n" | tee /etc/nginx/conf.d/ngx-push-state.conf

RUN npm install -g @angular/cli

VOLUME ["/var/www/html"]
EXPOSE 80