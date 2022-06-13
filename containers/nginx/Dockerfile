FROM nginx:1.16

# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*

# 初期状態の設定ファイル
ADD ./nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./nginx/default.conf /etc/nginx/conf.d/default.conf

# ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf