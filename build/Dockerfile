FROM centos:centos7

RUN yum install -y asciidoc fop graphviz ruby rubygem-json ImageMagick optipng

RUN mkdir -p /opt/dockbooker
RUN mkdir -p /in
RUN mkdir -p /out
RUN mkdir -p /make

#CMD ["/ww/run"]
VOLUME /in
VOLUME /out
ADD ./make /make
ADD ./dockbooker /opt/dockbooker

