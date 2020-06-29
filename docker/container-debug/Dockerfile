FROM ubuntu:20.04
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

COPY ssm-agent-start.sh /tmp/ssm-agent-start.sh
COPY ssm-agent-remove.sh /tmp/ssm-agent-remove.sh

RUN apt update && apt install -y \
        apt-transport-https \
        curl \
        dnsutils \
        gettext-base \
        init \
        jq \
        less \
        mysql-client \
        netcat \
        postgresql-client \
        python3-pip \
        redis-tools \
        strace \
        sudo \
        telnet \
        tzdata \
        unzip \
        vim \
        wget \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && echo "Asia/Tokyo" > /etc/timezone
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sh ./aws/install \
    && rm -rf aws awscliv2.zip
RUN wget https://s3.ap-northeast-1.amazonaws.com/amazon-ssm-ap-northeast-1/latest/debian_amd64/amazon-ssm-agent.deb \
    && apt install ./amazon-ssm-agent.deb \
    && rm -f amazon-ssm-agent.deb apt-key.gpg \
    && cp /etc/amazon/ssm/seelog.xml.template /etc/amazon/ssm/seelog.xml
