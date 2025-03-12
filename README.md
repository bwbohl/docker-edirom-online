# docker-Edirom-Online

A dockerimage for deploying Edirom-Online instances

start with

```bash
docker run -p 8080:8080 -v `pwd`/add-xars:/var/add-xars ghcr.io/bwbohl/docker-edirom-online
```

## Current Tags

The tags reflect the Edirom-Online EDIROM_VERSION. Current Tags are:

* latest: nightly build of the Edirom-Online repo’s develop branch
* nightly: nightly build of the Edirom-Online repo’s develop branch
* main: the build of the main branch of this repository
