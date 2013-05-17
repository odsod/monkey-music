readme: readme-css readme-html readme-pdf

readme-css: readme/assets/sass
	cd readme && compass compile

readme-html: README.md
	kramdown --template readme/template.html.erb README.md > readme/README.html

readme-pdf: readme/README.html
	wkhtmltopdf readme/README.html readme/README.pdf
