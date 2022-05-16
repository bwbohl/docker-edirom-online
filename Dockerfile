FROM stadlerpeter/existdb:6
MAINTAINER Benjamin W. Bohl
LABEL org.opencontainers.image.source=https://github.com/bwbohl/docker-Edirom-Online

ARG EDIROM_VERSION
ENV EDIROM_VERSION ${EDIROM_VERSION:-1.1.0-alpha}

ADD --chown=wegajetty:wegajetty https://github.com/Edirom/Edirom-Online/releases/download/v1.1.0-alpha/Edirom-Online-1.0.0-alpha.xar ${EXIST_HOME}/autodeploy/

USER wegajetty:wegajetty
COPY --chown=wegajetty:wegajetty edirom-entrypoint.sh ${EXIST_HOME}/
CMD ["./edirom-entrypoint.sh"]

EXPOSE 8080
