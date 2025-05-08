FROM stadlerpeter/existdb:6
# LABEL about this image
LABEL org.opencontainers.image.title="Docker Edirom-Online"
LABEL org.opencontainers.image.description="Dockerimage for running Edirom-Online"
LABEL org.opencontainers.image.revision="1.0.0-dev"
LABEL org.opencontainers.image.authors="Benjamin W. Bohl https://github.com/bwbohl"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.ref.name="bwbohl_edirom-online"
LABEL org.opencontainers.image.base.name="stadlerpeter/existdb:6"
LABEL org.opencontainers.image.documentation="https://github.com/bwbohl/docker-edirom-online"
LABEL org.opencontainers.image.source="https://github.com/bwbohl/docker-edirom-online"
LABEL org.opencontainers.image.url="https://github.com/bwbohl/docker-edirom-online"
LABEL org.opencontainers.image.version="1.0.0"

ARG EDIROM_VERSION
ENV EDIROM_VERSION=${EDIROM_VERSION:-1.0.0}
ENV EXIST_DEFAULT_APP_PATH=xmldb:exist:///db/apps/Edirom-Online
ENV EXIST_CONTEXT_PATH=/
ENV EXIST_ENV=development

#ADD --chown=wegajetty:wegajetty https://github.com/Edirom/Edirom-Online/releases/download/v${EDIROM_VERSION}/Edirom-Online-${EDIROM_VERSION}.xar ${EXIST_HOME}/autodeploy/

USER wegajetty:wegajetty
COPY add-xars/**/*.xar ${EXIST_HOME}/autodeploy/
COPY --chown=wegajetty:wegajetty edirom-entrypoint.sh ${EXIST_HOME}/
CMD ["./edirom-entrypoint.sh"]

EXPOSE 8080
