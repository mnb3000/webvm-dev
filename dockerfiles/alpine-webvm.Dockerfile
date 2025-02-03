FROM --platform=i386 mnb3000/dotfiles-image:alpine-webvm-main
# We set WORKDIR, as this gets extracted by Webvm to be used as the cwd. This is optional.
WORKDIR /home/mnb3000
# We set env, as this gets extracted by Webvm. This is optional.
ENV HOME="/home/mnb3000" TERM="xterm" USER="mnb3000" SHELL="/bin/zsh" EDITOR="nvim" LANG="en_US.UTF-8" LC_ALL="C"
CMD [ "/bin/zsh" ]
