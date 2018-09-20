FROM node:10-stretch
MAINTAINER Huiren Woo <giantcrabby@gmail.com>
LABEL maintainer="Huiren Woo <giantcrabby@gmail.com>"

RUN apt-get update \
    && apt-get install apt-transport-https -f

RUN wget 'https://cli.run.pivotal.io/stable?release=debian64&source=github' -O cf_cli.deb \
    && dpkg -i ./cf_cli.deb \
    && apt-get install -f \
    && cf --version

RUN cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org \
    && cf install-plugin blue-green-deploy -r CF-Community -f

RUN apt-get install nginx -f

RUN printf "server { \n\
                location / { \n\
                    try_files $uri $uri/ /index.html; \n\
                } \n\
            }\n" | tee /etc/nginx/conf.d/ngx-push-state.conf

RUN npm install -g @angular/cli

VOLUME ["/var/www/html"]
EXPOSE 80