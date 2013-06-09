all: clean sheet

clean:
	rm -rf tmp/ out/

scaled: export
	mkdir -p tmp/scaled
	cp export/*.png tmp/scaled/
	mogrify -resize 200% -filter box tmp/scaled/*.png

flipped: scaled
	mkdir -p tmp/flipped
	cp tmp/scaled/*.png tmp/flipped/
	mogrify -flop tmp/flipped/*.png
	cd tmp/flipped && rename 's/^/flipped_/' *.png

sheet: scaled flipped
	mkdir -p tmp/sheet
	cp tmp/scaled/*.png tmp/flipped/*.png tmp/sheet/
	mkdir -p out
	convert tmp/sheet/*.png +append out/sheet.png
