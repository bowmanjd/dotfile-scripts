FROM docker.io/library/alpine:latest

RUN apk add --no-cache \
    less \
    ncurses-terminfo-base \
    krb5-libs \
    libgcc \
    libintl \
    libssl1.1 \
    libstdc++ \
    tzdata \
    userspace-rcu \
    zlib \
    icu-libs \
    lttng-ust \
		git \
		dash \
		bash \
		zsh \
&& mkdir -p /opt/microsoft/powershell/7 \
&& wget -qO- https://github.com/PowerShell/PowerShell/releases/download/v7.3.6/powershell-7.3.6-linux-alpine-x64.tar.gz | tar x -zC /opt/microsoft/powershell/7 \
&& ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh \
&& wget -qO- https://git.io/shellspec | sh -s -- -y -p /usr \
&& adduser -D shelly

USER shelly
WORKDIR /home/shelly

RUN git config --global user.email "shelly@example.com" \
&& git config --global user.name "Shelly McShellerton" \
&& git config --global init.defaultBranch main \
&& git init -b base --bare /home/shelly/repos/bare.git \
&& git init -b base --bare /home/shelly/repos/base.git \
&& cd /tmp \
&& git clone /home/shelly/repos/base.git \
&& cd base \
&& touch .profile \
&& git add .profile \
&& git commit -m "Initial commit" \
&& git push \
&& cd .. \
&& rm -rf base \
&& git init -b base --bare /home/shelly/repos/empty.git \
&& git clone /home/shelly/repos/empty.git \
&& cd empty \
&& git commit --allow-empty -m "Initial commit" \
&& git push \
&& cd .. \
&& rm -rf empty \
&& cp -r /home/shelly/repos/base.git /home/shelly/repos/laptop.git \
&& cp -r /home/shelly/repos/base.git /home/shelly/repos/multibranch.git \
&& git clone /home/shelly/repos/multibranch.git \
&& cd multibranch \
&& git switch --orphan work \
&& touch .vimrc \
&& git add .vimrc \
&& git commit -m "Initial commit" \
&& git push -u origin work \
&& cd .. \
&& rm -rf multibranch \
&& pwsh -Command '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Install-Module Pester -Force'

LABEL maintainer="Jonathan Bowman <jonathan@bowmanjd.com>" \
	version="1.0.0"
