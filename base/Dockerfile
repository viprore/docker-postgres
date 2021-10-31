FROM centos:7

RUN yum update -y
RUN yum install -y java-1.8.0-openjdk net-tools curl netcat openssh-server sshpass
RUN echo 'root:123qwe' | chpasswd

RUN yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
RUN yum install -y postgresql13-server

RUN yum install -y https://www.pgpool.net/yum/rpms/4.2/redhat/rhel-7-x86_64/pgpool-II-release-4.2-1.noarch.rpm
RUN yum install -y pgpool-II-pg13-*
RUN echo 'postgres:postgres' | chpasswd

USER postgres
RUN mkdir /var/lib/pgsql/archivedir
USER root

ENTRYPOINT ["/sbin/init", "systemctl start sshd"]