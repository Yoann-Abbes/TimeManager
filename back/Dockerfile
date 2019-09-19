# Use an official Elixir runtime as a parent image
FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
RUN mkdir /app/back
COPY . /app/back/
WORKDIR /app/back

# Install hex package manager
RUN mix local.hex --force \
    && apt-get update -yq \
    && apt-get install curl gnupg -yq \
    && apt-get install inotify-tools -y \
    && apt-get install gcc \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash \
    && apt-get install nodejs -yq \
    && cd assets \
    && npm install \
    && cd /app/back

# Compile the project
RUN mix local.rebar --force
RUN mix deps.get
RUN cd deps/bcrypt_elixir && make clean && make && cd -
RUN mix do compile

CMD ["/app/back/entrypoint.sh"]