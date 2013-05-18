PAGE_MARGIN=2.5cm

readme: readme-css readme-html readme-pdf

readme-css: assets/sass/styles.sass
	compass compile

readme-html: ../README.md
	kramdown --template template.html.erb ../README.md > README.html

readme-pdf: README.html
	wkhtmltopdf -L $(PAGE_MARGIN) -R $(PAGE_MARGIN) -T $(PAGE_MARGIN) -B $(PAGE_MARGIN) README.html README.pdf
