FROM ubuntu:18.04
FROM multicloud/netcat

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN mkdir /net_throughput
ADD benchmark.sh /net_throughput
ADD entrypoint.sh /net_throughput
WORKDIR /net_throughput
RUN pwd
RUN echo 'root:Intel123!' | chpasswd
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENV NOTVISIBLE="in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN ./benchmark.sh >> resultbenchmark.txt
RUN ls
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
