# Makefile for converting the Jupyter notebooks into PDFs.
CONVERTER=jupyter-nbconvert
SOURCE  = $(wildcard *.ipynb)

pdf: $(SOURCE)
	$(CONVERTER) --to webpdf --allow-chromium-download $(SOURCE)

html: $(SOURCE)
	$(CONVERTER) --to html $(SOURCE)

# Clean up:
clean:
	rm -f *.html *.blg *.dvi *.log *.bbl *~ *.toc *.pdf
