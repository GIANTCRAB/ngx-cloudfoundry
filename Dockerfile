FROM node:10-stretch
MAINTAINER Huiren Woo <giantcrabby@gmail.com>
LABEL maintainer="Huiren Woo <giantcrabby@gmail.com>"

RUN apt-get update \
    && apt-get install apt-transport-https

RUN wget 'https://cli.run.pivotal.io/stable?release=debian64&source=github' -O cf_cli.deb \
    && dpkg -i ./cf_cli.deb \
    && apt-get install -f

RUN cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org \
    && cf install-plugin blue-green-deploy -r CF-Community -f

RUN npm install -g @angular/cli