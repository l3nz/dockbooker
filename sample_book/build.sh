#! /bin/bash

docker run -it --rm -v $(readlink -m .):/in -v $(readlink -m ./out):/out db /opt/dockbooker/dockbooker.rb
