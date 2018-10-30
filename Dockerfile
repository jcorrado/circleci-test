FROM debian:stretch
MAINTAINER Jereme Corrado <jereme@zoio.net>

ENV ELASTIC_REPO_KEY https://artifacts.elastic.co/GPG-KEY-elasticsearch
ENV ELASTIC_REPO https://artifacts.elastic.co/packages/6.x/apt

# Setup Elastic Co repo
RUN apt-get -y -qq update && \
    apt-get -y install apt-transport-https curl gnupg
RUN curl "$ELASTIC_REPO_KEY" | apt-key add -
RUN echo "deb $ELASTIC_REPO stable main" | tee -a /etc/apt/sources.list.d/elastic.list
RUN apt-get -y -qq update

# Elastic Co's Logstash packages do not include run-time deps, so you
# have to install the JRE manually.  When trying to roll this into one
# run of apt-get, the logstash pkg install scripts failed, so we split
# it out here.
RUN apt-get -y install default-jre
RUN java -version
RUN apt-get -y install logstash=1:6.4.0-1

EXPOSE 12201
ENTRYPOINT ["/usr/share/logstash/bin/logstash", "--path.settings=/etc/logstash"]
