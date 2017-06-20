#  Copyright (C) 2017  Nicholas Anderssohn
FROM nginx:alpine
# 80 for the web and 8079 for code-runner
EXPOSE 80 8079
RUN rm -rf /usr/share/nginx/html
RUN mkdir /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY build/web /usr/share/nginx/html
