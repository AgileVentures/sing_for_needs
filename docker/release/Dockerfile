FROM node:alpine as js-dependencies
WORKDIR /app
COPY assets/package*.json /app/
RUN  npm install

FROM elixir:1.8.1
LABEL application="sing_for_needs"

# Prevent dpkg errors
ENV TERM=xterm-256color

# Set the locale
ENV LANG="en_US.utf8"
ENV LANGUAGE="en_US:"

WORKDIR /application
COPY . /application/
RUN  mkdir -p assets/node_modules
COPY --from=js-dependencies ./app/node_modules assets/node_modules

# Update locale
RUN apt-get update && apt-get install -y --no-install-recommends locales
RUN export LANG=en_US.UTF-8 
RUN echo $LANG UTF-8 > /etc/locale.gen 
RUN locale-gen 
RUN update-locale LANG=$LANG

