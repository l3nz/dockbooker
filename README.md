# dockbooker

Create multi-format eBooks from the command line - using Docker.

Run a Docker image to transform your AsciiDoc documentation to:

* Multipart HTML
* PDF
* MOBI

It also makes sure that your images fit, and reprocesses them according to your destination media (for
example, images for PDF are to be 150dpi, JPEGs have a defined compression ratio, etc.)


#

docker run -it --rm -v /Users/lenz/dev/github/dockbooker/sample_book:/in -v /Users/lenz/dev/github/dockbooker/sample_book:/out db /opt/dockbooker/dockbooker.rb

docker run -it --rm -v $(readlink -m .):/in -v $(readlink -m ./build):/out db /opt/dockbooker/dockbooker.rb

## Centos7 Installation

yum install asciidoc
yum install fop
yum install graphviz
yum install ruby rubygem-json ImageMagick








## Buzilding pdf

a2x --icons --icons-dir=/usr/share/asciidoc/images/icons -f pdf --fop wqloader.txt



a2x -v --icons --icons-dir=/usr/share/asciidoc/images/icons -f pdf --fop --xsl-file=/root/documentation/config/Loway/LowayFOP.xsl wqloader.txt




a2x -v --icons --icons-dir=/usr/share/asciidoc/images/icons -f pdf --fop --xsl-file=xxx/LowayFOP.xsl WD_UserManual.txt
cp WD_UserManual.pdf /vagrant


Book Title Goes Here
====================
Author's Name
v1.0, 2003-12
:doctype: book




mk_dot    call_lifecycle
mk_dot    campaign_lifecycle
mk_dot    wd_schematics


chunked


a2x -v --icons --icons-dir=asciidoc_icons --doctype=book --destination-dir=/vagrant -f chunked WD_UserManual.txt
cp /usr/share/asciidoc/stylesheets/docbook-xsl.css /vagrant/WD_UserManual.chunked/
mkdir -p /vagrant/WD_UserManual.chunked/asciidoc_icons
cp -r /usr/share/asciidoc/images/icons /vagrant/WD_UserManual.chunked/asciidoc_icons


a2x -v --icons -f epub WD_UserManual.txt


