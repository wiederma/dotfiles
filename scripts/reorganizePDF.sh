#!/bin/bash
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

# Copyright 2013 Norbert Wiedermann

#==============================================================================
# prepare folder and files
mkdir -p even
mkdir -p odd
mkdir -p singlepages

cp $1 ./odd
cp $2 ./even

#==============================================================================
# EVEN

cd ./even

echo "splitting even file in single pages"
pdftk $2 burst #split pdf file

pages=$(ls pg_*.pdf | wc -l)
echo "processing " $pages " even pages ..."
echo "reversing order ..."

counter=2;
for oldFilename in $(ls -r pg_*.pdf);
	do if [ $pages -gt 4 ] && [ $pages -lt 100 ] && [ $counter -lt 10 ];
		then newFilename=page0$counter.pdf;
	else newFilename=page$counter.pdf;
	fi;
	echo old: $oldFilename new: $newFilename;
	mv $oldFilename $newFilename
	(( counter+=2 ));
done
echo "renaming even pages done !"

echo "moving even pages to folder singlepages"
mv page*.pdf ../singlepages/
cd ..

#==============================================================================
# ODD

cd ./odd

echo "splitting odd file in single pages"
pdftk $1 burst #split pdf file

pages=$(ls pg_*.pdf | wc -l)
echo "processing " $pages " odd pages ..."

counter=1;
for oldFilename in $(ls pg_*.pdf);
	do if [ $pages -gt 5 ] && [ $pages -le 100 ] && [ $counter -lt 10 ];
		then newFilename=page0$counter.pdf;
	else newFilename=page$counter.pdf;
	fi;
	echo old: $oldFilename new: $newFilename;
	mv $oldFilename $newFilename;
	(( counter+=2 ));
done
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
