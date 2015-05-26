FROM centos:centos7

RUN yum install -y asciidoc fop graphviz ruby rubygem-json ImageMagick optipng

RUN mkdir -p /opt/dockbooker
RUN mkdir -p /in
RUN mkdir -p /out

#CMD ["/ww/run"]
VOLUME /in
VOLUME /out
ADD ./dockbooker /opt/dockbooker
