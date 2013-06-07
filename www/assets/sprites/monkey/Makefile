all: clean sheets

clean:
	rm -rf tmp/ sheets/

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
	convert tmp/sheet/*.png +append tmp/sheet.png

sheets: sheet
	mkdir -p sheets
	cp tmp/sheet.png sheets
	@$(foreach i,$(shell seq 10 10 200),convert -modulate 100,100,$(i) sheets/sheet.png sheets/sheet_$(i).png;)
