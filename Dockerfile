FROM node:10-stretch
MAINTAINER Huiren Woo <giantcrabby@gmail.com>
LABEL maintainer="Huiren Woo <giantcrabby@gmail.com>"

RUN apt-get update \
    && apt-get install apt-transport-https ca-certificates

RUN wget 'https://cli.run.pivotal.io/stable?release=debian64&source=github' -O cf_cli.deb \
    && dpkg -i ./cf_cli.deb \
    && apt-get install -f \
    && cf --version

RUN cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org \
    && cf install-plugin blue-green-deploy -r CF-Community -f

RUN apt-get install nginx tee

RUN tee -a /etc/nginx/conf.d/ngx-push-state.conf << END
server {
    location / {
        try_files $uri $uri/ /index.html;
    }
}
END

RUN npm install -g @angular/cli

VOLUME ["/var/www/html"]
EXPOSE 80