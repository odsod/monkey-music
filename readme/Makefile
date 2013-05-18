readme: readme-css readme-html readme-pdf

readme-css: assets/sass/styles.sass
	compass compile

readme-html: ../README.md
	kramdown --template template.html.erb ../README.md > README.html

readme-pdf: README.html
	wkhtmltopdf README.html README.pdf
