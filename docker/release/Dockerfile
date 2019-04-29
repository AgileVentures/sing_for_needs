FROM elixir:1.8.1
LABEL application="sing_for_needs"

# Prevent dpkg errors
ENV TERM=xterm-256color

# Set the locale
ENV LANG="en_US.utf8"
ENV LANGUAGE="en_US:"

WORKDIR /application
COPY . /application/

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get install --yes nodejs
RUN node -v
RUN npm -v
RUN apt-get install -y -q inotify-tools

# Install node dependencies
WORKDIR /application/assets
RUN npm install

# shift context back
WORKDIR /application

# Update locale
RUN apt-get update && apt-get install -y --no-install-recommends locales
RUN export LANG=en_US.UTF-8 
RUN echo $LANG UTF-8 > /etc/locale.gen 
RUN locale-gen 
RUN update-locale LANG=$LANG

# Install local.hex and local.rebar
RUN mix local.hex --force
RUN mix local.rebar --force

# Install phoenix dependencies
RUN mix deps.get
RUN mix deps.compile                                    

EXPOSE 4000

RUN chmod +x /application/docker/scripts/create_migrate_db.sh

ENTRYPOINT ["/application/docker/scripts/create_migrate_db.sh"]
