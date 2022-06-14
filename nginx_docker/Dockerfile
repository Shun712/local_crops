FROM nginx:1.16

# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*

# 初期状態の設定ファイル
ADD nginx.conf /etc/nginx/conf.d/local_crops.conf

# ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf