# =====================================================================
#  .latexmkrc — configuracion de latexmk
#  Hace que `latexmk` sin argumentos ya funcione correctamente.
# =====================================================================

# Motor: pdflatex. Para cambiar a lualatex o xelatex ajusta $pdf_mode
# (1 = pdflatex, 4 = lualatex, 5 = xelatex) y adapta preamble/packages.tex.
$pdf_mode = 1;

# -interaction=nonstopmode  -> no se queda esperando en los errores
# -synctex=1                -> permite saltar del PDF al .tex en el editor
# -file-line-error          -> errores en formato archivo:linea, mas legibles
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 -file-line-error %O %S';

# Bibliografia con biber (biblatex)
$bibtex_use = 2;
$biber = 'biber --validate-datamodel %O %S';

# Todo lo intermedio va a build/ para no ensuciar la raiz
$out_dir = 'build';
$aux_dir = 'build';

# Documento por defecto cuando se llama a latexmk sin argumentos
@default_files = ('main.tex');

# Archivos extra que `latexmk -c` debe borrar
$clean_ext = 'bbl run.xml synctex.gz nav snm vrb figlist makefile fls';
