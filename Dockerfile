FROM stadlerpeter/existdb:6.1
MAINTAINER Benjamin W. Bohl
LABEL org.opencontainers.image.source=https://github.com/bwbohl/docker-edirom-online

ARG EDIROM_VERSION
ENV EDIROM_VERSION ${EDIROM_VERSION:-1.0.0-beta.5}
ENV EXIST_DEFAULT_APP_PATH=xmldb:exist:///db/apps/Edirom-Online
ENV EXIST_CONTEXT_PATH=/
ENV EXIST_ENV=development

ADD --chown=wegajetty:wegajetty https://github.com/Edirom/Edirom-Online/releases/download/v${EDIROM_VERSION}/Edirom-Online-${EDIROM_VERSION}.xar ${EXIST_HOME}/autodeploy/

USER wegajetty:wegajetty
COPY --chown=wegajetty:wegajetty edirom-entrypoint.sh ${EXIST_HOME}/
CMD ["./edirom-entrypoint.sh"]

EXPOSE 8080
