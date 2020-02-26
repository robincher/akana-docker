FROM ronaldkan/akana-base:latest
COPY controlplane/properties/* /opt/installer/
WORKDIR /usr/src/app
COPY controlplane/entrypoint.sh /usr/src/app/
RUN chmod 755 entrypoint.sh
EXPOSE 9900 8443
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]