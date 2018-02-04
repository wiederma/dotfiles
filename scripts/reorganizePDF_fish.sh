#!/usr/bin/fish

# 2018-01-10:
# this script is adapted to use fish shell

# this script needs pdftk to be installed on the system
# sudo apt-get install pdftk

# use the script in a temp folder and with copies of the pdf which are processed
# use at your own risk!
# this script can handle scans of printed documents with up to 99 pages


# How to use
# ----------
# you have a double-sided printed document
# scan it with the develop printer in room 11:
# 1)	scan odd pages
#			put the document face down in the scanning duct of the printer
#			start scanning, the pdf document you receive via email has the odd pages
#			in the right order
# 2)	scan even pages
#			put the document face up in the scanning duct of the printer
#			start scanning, the pdf document you receive via email has the even pages
#			in REVERSED order
# 3)	name the files according to the pages the contain (odd, even_reversed)
#			and run the script:
#			(first time, add execute rights: chmod +x reorganizePDF.sh)
#			./reorganizePDF oddpages.pdf even_reversed_ordered.pdf
#			That creates a file "merged.pdf" in the same folder where odd.pdf and
#			even.pdf are stored

# Copyright 2018 Norbert Wiedermann

# Quellen:
# https://fishshell.com/docs/current/tutorial.html#tut_exports
# https://butterflyprogramming.neoname.eu/programming-with-fish-shell/

#==============================================================================
# prepare folder and files
mkdir -p even
mkdir -p odd
mkdir -p singlepages

cp $argv[1] ./odd/
cp $argv[2] ./even/

#==============================================================================
# EVEN

cd ./even

echo "splitting even file in single pages"
#split pdf file
pdftk $argv[2] burst

set pages (ls pg_*.pdf | wc -l)
echo "processing " $pages " even pages ..."
echo "reversing order ..."

set counter 2;
for oldFilename in (ls -r pg_*.pdf)
	if [ $pages -gt 4 ]; and [ $pages -lt 100 ]; and [ $counter -lt 10 ];
	    set newFilename page0$counter.pdf;
	else
   		set newFilename page$counter.pdf;
	end
	echo old:$oldFilename new:$newFilename;
	mv $oldFilename $newFilename
	set counter (math "$counter+2")
end

echo "renaming even pages done !"

echo "moving even pages to folder singlepages"
mv page*.pdf ../singlepages/
cd ..

#==============================================================================
# ODD

cd ./odd

echo "splitting odd file in single pages"
pdftk $argv[1] burst #split pdf file

set pages (ls pg_*.pdf | wc -l)
echo "processing " $pages " odd pages ..."

set counter 1;
for oldFilename in (ls pg_*.pdf)
	if [ $pages -gt 5 ]; and [ $pages -le 100 ]; and [ $counter -lt 10 ];
	    set newFilename page0$counter.pdf;
	else
   		set newFilename page$counter.pdf;
	end
	echo old:$oldFilename new:$newFilename;
	mv $oldFilename $newFilename
	set counter (math "$counter+2")
end

echo "renaming done !"

echo "moving odd pages to folder singlepages"
mv page*.pdf ../singlepages/
cd ..

#==============================================================================
# merge new pdf file

cd ./singlepages
echo "merging single pages ..."
pdftk *.pdf cat output ../merged.pdf

#==============================================================================
# clean up
echo "tidy up ..."
cd ..
rm -rf even
rm -rf odd
echo "done"
