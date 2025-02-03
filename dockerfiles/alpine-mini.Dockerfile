FROM --platform=i386 bash:devel-alpine3.21

RUN apk upgrade
RUN apk add bash shadow sudo git alpine-conf xdg-user-dirs less

RUN setup-user -a "mnb3000"
RUN sudo -u "mnb3000" xdg-user-dirs-update
RUN echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >>/etc/sudoers
RUN [ "bash", "-c", "chsh -s /bin/bash" ]

USER "mnb3000"
WORKDIR /home/mnb3000/
RUN git clone --recursive https://github.com/mnb3000/dotfiles.git ./.dotfiles

WORKDIR /home/mnb3000/.dotfiles
ENV DOTBOT_PROFILE=webvm/alpine
ENV DOTBOT_TARGET=alpine
RUN bash ./scripts/install.sh

# We set WORKDIR, as this gets extracted by Webvm to be used as the cwd. This is optional.
WORKDIR /home/mnb3000/
# We set env, as this gets extracted by Webvm. This is optional.
ENV HOME="/home/mnb3000" TERM="xterm" USER="user" SHELL="/bin/bash" EDITOR="vim" LANG="en_US.UTF-8" LC_ALL="C"
CMD [ "/bin/zsh" ]
