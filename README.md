# SuperPC_2026

Documento LaTeX modular, compilado con `latexmk` + `biber`.

## Requisitos

TeX Live con los paquetes usados en `preamble/packages.tex`:

```bash
sudo dnf install texlive-scheme-medium latexmk biber
```

Si falta algún paquete durante la compilación, instálalo por su nombre:
`sudo dnf install 'tex(nombre.sty)'`.

## Compilar

```bash
make            # genera build/main.pdf
make watch      # recompila al guardar
make open       # abre el PDF
make clean      # borra intermedios, conserva el PDF
make distclean  # borra todo lo generado
make help       # lista los objetivos
```

El PDF sale en `build/main.pdf`. La raíz del repositorio se mantiene
limpia porque `.latexmkrc` fija `$out_dir = 'build'`.

## Estructura

```
main.tex              Documento raíz: metadatos y orden de las secciones
preamble/
  packages.tex        Paquetes, idioma y codificación
  style.tex           Márgenes, encabezados, colores, teoremas
  macros.tex          Comandos propios (\pc, \comp, \precio, ...)
sections/
  00-resumen.tex      Resumen (va dentro del entorno abstract)
  01-introduccion.tex
  02-desarrollo.tex   Ejemplos de figura, tabla, ecuación y código
  03-conclusiones.tex
figures/              Imágenes (\graphicspath ya apunta aquí)
bib/referencias.bib   Bibliografía
build/                Salida y archivos intermedios (ignorado por git)
```

## Convenciones

- Una sección por archivo en `sections/`, con prefijo numérico para
  mantener el orden de lectura. Se añaden a `main.tex` con `\input`.
- Las imágenes se referencian sin carpeta ni extensión:
  `\includegraphics{esquema}`, no `figures/esquema.png`.
- Referencias cruzadas con `\cref{...}`, nunca el número a mano.
  Etiquetas con prefijo: `sec:`, `fig:`, `tab:`, `eq:`, `lst:`.
- Cifras con unidad mediante `siunitx`: `\SI{5.4}{\giga\hertz}`.
- Tablas con `booktabs`: sin reglas verticales.
- El pie de las figuras va debajo; el de las tablas, encima.
- Términos que se repiten se definen como macro en
  `preamble/macros.tex` para que no se escriban de dos formas distintas.

## Cambiar de motor

El valor por defecto es `pdflatex`. Para `lualatex` o `xelatex`:

1. En `.latexmkrc`, cambia `$pdf_mode` a `4` (lualatex) o `5` (xelatex).
2. En `preamble/packages.tex`, sustituye `inputenc` y `fontenc` por
   `\usepackage{fontspec}`.
