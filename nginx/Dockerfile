FROM nginx:1.17.3
COPY ./files/modules/*.so /usr/share/nginx/modules/
RUN ls -llh /etc/nginx/modules/
#RUN ./configure --with-compat --add-dynamic-module=modules/ngx_http_brotli_filter_module
