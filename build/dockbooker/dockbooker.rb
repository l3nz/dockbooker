#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'pp'
require 'erb'
require 'net/http'

#
srcdir = "/opt/dockbooker/data"
destfolder="/out"


#
fopxlst= "/usr/share/sgml/docbook/xsl-stylesheets-1.78.1"
file_name = "dockbooker.json"
mode = :PDF

#

SIZE={
	:MAXI => "-resize 960  -sharpen 2 -colors 256 -depth 8 +dither",
	:MIDI => "-resize 480  -sharpen 2 -colors 256 -depth 8 +dither",
	:MINI => "-resize 240  -sharpen 2 -colors 256 -depth 8 +dither",
	:SAME => "-colors 256 -depth 8 +dither",
}


CONVERT="convert"
DOT="dot"
DPI=" -density 72x72 -units PixelsPerInch "


# copy all data from  /in
%x{cp -r /in/* #{srcdir}}

json_blob = File.read( srcdir + "/" +  file_name)
data = JSON.parse( json_blob )


# processa le immagini

pp data["img"]

input_file= data["input"]
input_name = File.basename( input_file, ".*" )
output_name = data["output"]

data["img"].map.each { |name,attrs| 

	#%x{./backupContainer.sh web#{cli}}
	src_file = srcdir + "/" + name #+ "_____"
	if File.exists?( src_file )

		dotsrc = attrs["dotsrc"]
		if !dotsrc.nil?
			puts( "Building dotfile #{dotsrc}")
			#$DOT -oimg.gif -Tgif dotfiles/$1.dot.txt
			%x{dot -Tpng -o#{src_file} #{srcdir}/#{dotsrc}}
		end


		puts( "Converting #{src_file}")
		opts = SIZE[ attrs["size"].to_sym ]
		cmd = "convert -colors 256 #{src_file} #{opts} #{DPI} #{src_file}"
		%x{#{cmd}}

		puts( "EXT: " +  File.extname( src_file ) )

		if File.extname( src_file ).upcase == ".PNG"
			puts( "Optimizing PNG: #{src_file} ")
			%x{optipng #{src_file} }
		end


	else
		puts( "No file #{src_file}")
	end

}

a2x_call="a2x -v --icons  --doctype=book --destination-dir=#{destfolder}"

case mode
	when :PDF
		custom_style=data["docbook"]["custom-style"]
		xls_cmd = ""
		if !custom_style.empty? 
			xsl_cmd = "--xsl-file=./#{custom_style}.1"

			xf = File.read( srcdir + "/" + custom_style )
			    .gsub("##XSLDOCBOOK##", fopxlst)
			    .gsub("##HOME##", srcdir)

			File.write(srcdir + "/" + custom_style + ".1", xf)

		end
		
		%x{cd #{srcdir} && #{a2x_call} --icons-dir=/usr/share/asciidoc/images/icons -f pdf --fop #{xsl_cmd} #{input_file} }
		%x{cd #{destfolder} && mv #{input_name}.pdf #{output_name}.pdf}
		

	when :CHUNKED
		%x{cd #{srcdir} && #{a2x_call} --icons-dir=asciidoc_icons -f chunked #{input_file} }
		%x{cp /usr/share/asciidoc/stylesheets/docbook-xsl.css /vagrant/#{input_name}.chunked/}
		%x{mkdir -p #{destfolder}/#{input_name}.chunked/asciidoc_icons}
		%x{cp -r /usr/share/asciidoc/images/icons #{destfolder}/#{input_name}.chunked/asciidoc_icons}


	when :EPUB
		#a2x -v --icons -f epub WD_UserManual.txt
		%x{cd #{srcdir} && #{a2x_call}  -f epub #{input_file} }
		%x{cd #{destfolder} && mv #{input_name}.epub #{output_name}.epub}
		
end



