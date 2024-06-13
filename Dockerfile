FROM elixir:1.17.0

ENV TZ Asia/Tokyo

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    sqlite3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
