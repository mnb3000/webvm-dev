FROM --platform=i386 i386/debian:unstable
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get clean && apt-get update && apt-get -y upgrade
RUN apt-get install -y bash sudo git xdg-user-dirs

RUN useradd -G sudo -m mnb3000 && echo "mnb3000:password" | chpasswd
RUN sudo -u "mnb3000" xdg-user-dirs-update
RUN echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >>/etc/sudoers

USER "mnb3000"
WORKDIR /home/mnb3000/
RUN git clone --recursive https://github.com/mnb3000/dotfiles.git ./.dotfiles

WORKDIR /home/mnb3000/.dotfiles
ENV DOTBOT_PROFILE=webvm/debian
ENV DOTBOT_TARGET=debian
RUN bash ./scripts/install.sh

# We set WORKDIR, as this gets extracted by Webvm to be used as the cwd. This is optional.
WORKDIR /home/mnb3000/
# We set env, as this gets extracted by Webvm. This is optional.
ENV HOME="/home/mnb3000" TERM="xterm" USER="user" SHELL="/bin/bash" EDITOR="vim" LANG="en_US.UTF-8" LC_ALL="C"
RUN echo 'root:password' | chpasswd
CMD [ "/bin/bash" ]
