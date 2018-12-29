# Angular 6 With Cloud Foundry Push
[![Build Status](https://travis-ci.org/GIANTCRAB/ngx-cloudfoundry.svg?branch=master)](https://travis-ci.org/GIANTCRAB/ngx-cloudfoundry)

Docker environment required to build Angular 6 and enables you to push directly to Cloud Foundry through Blue-Green deployment.

## Usage

Use this for your build/test environment.

### Deployment

You could run the following bash command to easily deploy to Cloud Foundry.

```
cf login -a $CF_API_ENDPOINT -u $CF_USERNAME -p $CF_PASSWORD -o $CF_ORGANIZATION -s $CF_SPACE && cf check-manifest $CF_APP && cf blue-green-deploy $CF_APP
```

Environment variables required:

* CF_API_ENDPOINT - API Endpoint which you would like to deploy to. Eg: api.run.pivotal.io (PWS)
* CF_USERNAME - Cloud Foundry username used for logging in.
* CF_PASSWORD - Cloud Foundry password used for logging in.
* CF_ORGANIZATION - Organization name.
* CF_SPACE - The space/environment which you deploy your app to.
* CF_APP - The name of your Cloud Foundry app in its respective org and space.