#! /bin/bash

docker run -it --rm -v $(readlink -m .):/in -v $(readlink -m ./out):/out db /make/all



#/opt/dockbooker/dockbooker.rb
