FROM elixir:1.9

# Install node
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt install -y nodejs

# Install package managers
RUN ["mix", "local.hex", "--force"]
RUN ["mix", "local.rebar", "--force"]

ADD . /app
WORKDIR /app

EXPOSE 4000

CMD ["mix", "do", "deps.get,", "deps.compile,", "phx.server"]
