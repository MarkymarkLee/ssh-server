FROM nvidia/cuda:12.3.1-runtime-ubuntu22.04

# Update the system
RUN apt-get update && apt-get upgrade -y

# Install OpenSSH Server
RUN apt-get install -y openssh-server iproute2 sudo vim

# Set up configuration for SSH
RUN mkdir /var/run/sshd
RUN echo '0000\n0000\n' | passwd root

# SSH login fix. Otherwise, user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN groupadd -g 1000 uu
RUN useradd --uid 1000 --gid 1000 --groups root,sudo,adm,users --create-home --shell /bin/bash mark
RUN echo '0000\n0000\n' | passwd mark
RUN echo '%sudo ALL=(ALL) ALL' >> /etc/sudoers

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Expose the SSH port
EXPOSE 22

# Run SSH
CMD ["/usr/sbin/sshd", "-D"]
