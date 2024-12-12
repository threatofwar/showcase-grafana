FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    curl \
    apt-transport-https \
    gnupg2 \
    lsb-release && \
    curl https://packages.grafana.com/gpg.key | tee /etc/apt/trusted.gpg.d/grafana.asc && \
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/grafana.asc] https://packages.grafana.com/oss/deb stable main" | tee /etc/apt/sources.list.d/grafana.list && \
    apt-get update && \
    apt-get install -y grafana=11.4.0

EXPOSE 3000

CMD ["grafana-server", "web"]
