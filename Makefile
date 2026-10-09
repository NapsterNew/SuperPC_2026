# =====================================================================
#  Makefile — atajos de compilacion para SuperPC_2026
#  La configuracion real del compilador esta en .latexmkrc
# =====================================================================

DOC      := main
BUILDDIR := build
PDF      := $(BUILDDIR)/$(DOC).pdf
LATEXMK  := latexmk

.PHONY: all watch clean distclean check open help

## all: compila el PDF (objetivo por defecto)
all: $(PDF)

$(PDF): $(DOC).tex $(wildcard preamble/*.tex) $(wildcard sections/*.tex) $(wildcard bib/*.bib)
	$(LATEXMK) $(DOC).tex

## watch: recompila automaticamente al guardar cualquier archivo
watch:
	$(LATEXMK) -pvc $(DOC).tex

## open: abre el PDF generado
open: $(PDF)
	xdg-open $(PDF) >/dev/null 2>&1 &

## check: compila tratando los avisos de referencias como fallo
check:
	$(LATEXMK) -pdf -Werror $(DOC).tex

## clean: borra los archivos intermedios y conserva el PDF
clean:
	$(LATEXMK) -c $(DOC).tex

## distclean: borra todo lo generado, incluido el PDF
distclean:
	$(LATEXMK) -C $(DOC).tex
	rm -rf $(BUILDDIR)

## help: muestra esta ayuda
help:
	@grep -E '^## ' $(MAKEFILE_LIST) | sed 's/## /  /'
