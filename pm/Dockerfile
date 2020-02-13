FROM centos:centos7

COPY opt /opt/
WORKDIR /usr/src/app
COPY pm/entrypoint.sh /usr/src/app/
RUN chmod 755 entrypoint.sh
EXPOSE 9900
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]