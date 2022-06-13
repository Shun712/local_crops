# ベースにするイメージを指定
FROM ruby:2.7.5

ENV RAILS_ENV=production

# Docker内でコマンドを実行する
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && apt-get update && \
    apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev sudo vim

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn && apt-get install imagemagick

RUN yarn add node-sass

# 作成したディレクトリを作業用ディレクトリとして設定
WORKDIR /local_crops
RUN mkdir -p tmp/pids
RUN mkdir -p tmp/sockets
COPY Gemfile /local_crops/Gemfile
COPY Gemfile.lock /local_crops/Gemfile.lock
COPY yarn.lock /local_crops
COPY package.json /local_crops
RUN gem install bundler
# bundle installを並列処理
RUN bundle install --jobs 4
# ここでyarn installをしないとwebpackerを実行できない
RUN yarn install
COPY . /local_crops

# RUN yarn add jquery popper.js bootstrap

# WARNING:webpack:installをするとwebpackの設定ファイルが初期化されてjqueryなどが使えなくなってしまう
# RUN rails webpacker:install
RUN NODE_ENV=production ./bin/webpack

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# 以下の記述があることでnginxから見ることができる
VOLUME /local_crops/public
VOLUME /local_crops/tmp

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec puma -C config/puma.rb"
