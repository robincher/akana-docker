FROM ronaldkan/akana-base:latest

WORKDIR /usr/src/app
COPY controlplane/entrypoint.sh /usr/src/app/
RUN chmod 755 entrypoint.sh
EXPOSE 9900
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]