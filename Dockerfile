FROM node:10-stretch
MAINTAINER Huiren Woo <giantcrabby@gmail.com>
LABEL maintainer="Huiren Woo <giantcrabby@gmail.com>"

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN apt-get update \
    && apt-get install apt-transport-https

RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - \
    && echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list \
    && apt-get install cf-cli

RUN cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org \
    && cf install-plugin blue-green-deploy -r CF-Community -f

RUN npm install -g @angular/cli