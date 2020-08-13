FROM centos:centos8

ARG http_proxy
ARG https_proxy


# Require for CHE
# Change permissions to let any arbitrary user
ENV HOME=/home/theia
RUN mkdir /projects ${HOME} && \
    for f in "${HOME}" "/etc/passwd" "/projects"; do \
      echo "Changing permissions on ${f}" && chgrp -R 0 ${f} && \
      chmod -R g+rwX ${f}; \
    done
ADD etc/entrypoint.sh /entrypoint.sh
    
# Install docker && docker compose
RUN \
  yum -y install yum-utils &&\
  yum-config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo &&\
  yum -y  install docker-ce --nobest &&\
  useradd user &&\
  usermod -aG docker user

# Clean image
RUN \
    yum clean all &&\
    rm -rf /tmp/*
    
USER user

WORKDIR "/projects"

CMD ["sleep", "infinity"]
