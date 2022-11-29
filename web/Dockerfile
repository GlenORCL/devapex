FROM nginx:alpine

COPY software/apex.zip /tmp/
COPY default.conf /etc/nginx/conf.d/default.conf

RUN unzip -q /tmp/apex.zip apex/images/* -d /tmp/ \
&& cp -Rp /tmp/apex/images /usr/share/nginx/html/ \
&& rm -f /tmp/apex.zip \
&& rm -Rf /tmp/apex
