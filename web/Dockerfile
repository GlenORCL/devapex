FROM nginx:alpine
RUN curl https://download.oracle.com/otn_software/apex/apex_22.2_en.zip -o /tmp/apex_22_2_en.zip  \
&& unzip /tmp/apex_22_2_en.zip apex/images/* -d /tmp/ \
&& cp -Rp /tmp/apex/images /usr/share/nginx/html/ \
&& rm /tmp/apex_22_2_en.zip

COPY default.conf /etc/nginx/conf.d/default.conf
