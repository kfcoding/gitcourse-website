hugo --baseUrl="http://kfcoding.github.io/" && \
  docker run -it -p 80:80 -v /Users/wsl/Downloads/hugoDocs-master\ 2/public:/usr/share/nginx/html/ nginx