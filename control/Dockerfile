FROM viprore/cluster-base:HEAD

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum update -y
RUN yum install -y ansible
RUN yum install -y openssh-clients

COPY sshkey/id_rsa /root/.ssh/id_rsa
COPY sshkey/id_rsa.pub /root/.ssh/id_rsa.pub

RUN chmod 600 /root/.ssh/id_rsa
RUN chmod 644 /root/.ssh/id_rsa.pub

RUN yum install -y sudo