> [!CAUTION]
> This repository has been archived. Development continues at:
> https://github.com/BAZ-GA/docker-edirom-online
>
> This was the initial proof-of-concept. The production version
> with extensive features is maintained by the
> Bernd Alois Zimmermann-Gesamtausgabe
>
> ## Original License
> This repository was originally MIT licensed. The successor project
> uses GNU GPL v.3 to match Edirom Online's license.

# docker-Edirom-Online [ARCHIVED]

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
