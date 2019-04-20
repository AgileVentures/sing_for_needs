FROM elixir:1.8.1
LABEL application="sing_for_needs"

# Prevent dpkg errors
ENV TERM=xterm-256color

# Set the locale
ENV LANG="en_US.utf8"
ENV LANGUAGE="en_US:"

WORKDIR /app

COPY . /app/

# Update locale
RUN apt-get update && apt-get install -y --no-install-recommends locales
RUN export LANG=en_US.UTF-8 
RUN echo $LANG UTF-8 > /etc/locale.gen 
RUN locale-gen 
RUN update-locale LANG=$LANG

