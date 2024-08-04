FROM elixir:1.17.2

ENV TZ Asia/Tokyo

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*
