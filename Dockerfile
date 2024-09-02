FROM prom/cloudwatch-exporter:v0.16.0

WORKDIR /
COPY config*.yml /
COPY exporter.sh /
RUN chmod 755 /exporter.sh

LABEL container.name=wehkamp/prometheus-cloudwatch-exporter:1.5.0-1
ENTRYPOINT ["/exporter.sh"]
EXPOSE 9106
