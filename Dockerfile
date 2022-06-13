# ベースにするイメージを指定
FROM ruby:2.7.5
ARG ROOT="/local_crops"

# 作成したディレクトリを作業用ディレクトリとして設定
WORKDIR ${ROOT}

# Docker内でコマンドを実行する
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    locales \
    vim \
    nginx \
    nodejs \
    yarn \
    mariadb-client && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

COPY Gemfile ${ROOT}
COPY Gemfile.lock ${ROOT}
RUN gem install bundler
# bundle installを並列処理
RUN bundle install --jobs 4

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
# 指定されたコマンドを実行
ENTRYPOINT ["entrypoint.sh"]
# コンテナ起動時に公開することを想定されているポートを記述
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]