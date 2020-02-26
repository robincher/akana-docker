FROM ronaldkan/akana-base:latest

COPY nd/properties/* /opt/installer/
WORKDIR /usr/src/app
COPY nd/entrypoint.sh /usr/src/app/
RUN chmod 755 entrypoint.sh
EXPOSE 9991 8443
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]