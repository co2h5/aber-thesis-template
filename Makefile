FILENAME=thesis-main

ifeq ($(OS),Windows_NT)
	OPT =
	OPT_BIB =
else
	OPT =
	OPT_BIB =
endif

all:
	pdflatex $(OPT) $(FILENAME).tex
	bibtex $(OPT_BIB) $(FILENAME)
	pdflatex $(OPT) $(FILENAME).tex
	pdflatex $(OPT) $(FILENAME).tex

pdf:
	pdflatex $(OPT) $(FILENAME).tex

bibtex:
	bibtex $(OPT_BIB) $(FILENAME)

ps: all
	pdftocairo -ps -r 1200 $(FILENAME).pdf $(FILENAME).ps

printpdf: ps
	ps2pdf -dPDFSETTINGS=/prepress -dEmbedAllFonts=true $(FILENAME).ps $(FILENAME)_print.pdf

pdf2pag: all
	pdflatex $(OPT) $(FILENAME)_2pag.tex

checkfonts: pdf
	pdffonts $(FILENAME).pdf

docx:
	pandoc --bibliography=references.bib --from=latex --to=docx -o $(FILENAME).docx $(FILENAME).tex

html:
	pandoc --bibliography=references.bib -s --from=latex --to=html -o $(FILENAME).html --data-dir=$(FILENAME)_html $(FILENAME).tex

odt:
	pandoc --bibliography=references.bib --from=latex --to=odt -o $(FILENAME).odt $(FILENAME).tex

clean:
	rm -fv *.4ct *.4tc *.css *.idv *.lg *.tmp *.xref *.aux *.dvi *.blg *.ist *.ilg *.ind *.bbl *.log *.out *.glo *.idx *.lof *.lot *.toc *.synctex.gz *.bak tex/*.aux

allclean: clean
	rm -fv $(FILENAME).pdf
	rm -fv $(FILENAME).ps
	rm -fv $(FILENAME).odt
	rm -fv $(FILENAME).docx
	rm -fv $(FILENAME).html
	rm -fv $(FILENAME)_print.pdf
	rm -fv $(FILENAME)_2pag.pdf
