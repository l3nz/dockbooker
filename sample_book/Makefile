
CMD=docker run -it --rm -v $$(readlink -m .):/in -v $$(readlink -m ./out):/out


all:
	$(CMD) lenz/dockbooker /make/all

pdf:
	$(CMD) lenz/dockbooker /make/pdf

html:
	$(CMD) lenz/dockbooker /make/html

epub:
	$(CMD) lenz/dockbooker /make/epub


