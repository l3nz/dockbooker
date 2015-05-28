# dockbooker

Create multi-format eBooks from the command line - using Docker.

Run a Docker image to transform your AsciiDoc documentation to:

* Multipart HTML
* PDF
* EPUB

It also makes sure that your images fit, and reprocesses them according to your destination media (for
example, images for PDF are to be 150dpi, JPEGs have a defined compression ratio, etc.)

## Getting started

If you have Docker installed, just clone the repo, then go to "sample_book" and run "make".
The sample document will be compiled to all formats - PDF, HTML and EPUB.

## Using

The Docker image expects sources to be mounted as /in and output to be mounted as /out. Though the 
contents of /in are read-only, it is perfectly acceptable to map /in and /out to the same folder.

You will run the Docker image as:

   docker run -it --rm \
       -v $(readlink -m .):/in \
       -v $(readlink -m ./out):/out \
       lenz/dockbooker \
       /make/all

The first line runs the image and removes it when terminated. The second and third line
mount volumes on /in and /out (note that we have to use readlink to make local paths absolute).
The last line runs the correct command "/make/all".

# Creating books

A book is created out of a folder containing an Asciidoc file, its images and a manifest
file dockbooker.json.

The manifest:

* Defines what to compile and how to name the resulting file
* Defines how you want your images processed

The idea is that you keep images in the simplest possibe format - be it text (for dotfiles) or
high-resoution, full-color graphics.

When rendering, dockbooker takes care of rendering the images with a size and a resolution
that looks good, but is usually compressed - for example, PNGs are reduced to 256 colors
and packed. So for each image you can simply add to your repo the image as-is, without processing it,
and dockbooker will process it.

The idea is that images can be either MAXI (full page), MIDI (about 2/3) and MINI (about 1/3 of the page).


## Creating PDFs with covers

It is possible to customize PDFs by adding Docbook customization files. The one supplied lets you add
a picture on the cover page and a small logo on the footer of each page. 

In theory, you can customize the appearance of Docbook books quite a lot. In practice, it's so 
absurdly complex that and contribution on how to do this in practice is welcome.







