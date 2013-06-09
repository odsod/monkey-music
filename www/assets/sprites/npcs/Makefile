all: clean sheet

clean:
	rm -rf tmp/ out/

scaled: export
	mkdir -p tmp/scaled
	cp export/*.png tmp/scaled/
	mogrify -resize 200% -filter box tmp/scaled/*.png

sheet: scaled
	mkdir -p out
	convert tmp/scaled/*.png +append out/sheet.png
