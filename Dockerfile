FROM centos:centos8

ARG http_proxy
ARG https_proxy


# Required for che
ADD https://raw.githubusercontent.com/disaster37/che-scripts/master/centos.sh /tmp/centos.sh
RUN sh /tmp/centos.sh
    
# Install docker && docker compose
RUN \
  yum -y install yum-utils
  yum-config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo &&\
  yum -y  install docker-ce --nobest &&\
  groupadd docker &&\
  usermod -aG docker dev

# Clean image
RUN \
    yum clean all &&\
    rm -rf /tmp/*

WORKDIR "/projects"

CMD ["sleep", "infinity"]
