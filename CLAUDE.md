# CLAUDE.md

Documento LaTeX modular (`article`, español, `pdflatex` + `biber`).

## Compilación

```bash
make          # -> build/main.pdf
make check    # falla ante referencias o citas sin resolver
make distclean
```

Nunca invoques `pdflatex` directamente: `latexmk` es quien decide cuántas
pasadas hacen falta para resolver `\cref` y la bibliografía. Toda la
configuración del compilador vive en `.latexmkrc`, no en el `Makefile`.

Un fallo de compilación se diagnostica en `build/main.log`, buscando la
primera línea que empiece por `!`. Los avisos `Overfull \hbox` son ruido
tipográfico, no errores.

## Dónde va cada cambio

| Tipo de cambio | Archivo |
|---|---|
| Añadir un paquete | `preamble/packages.tex` |
| Márgenes, colores, títulos, teoremas | `preamble/style.tex` |
| Comando reutilizable | `preamble/macros.tex` |
| Texto del documento | `sections/NN-*.tex` |
| Orden de las secciones, título, autor | `main.tex` |

No metas `\usepackage` ni `\newcommand` en los archivos de `sections/`:
el preámbulo se carga una sola vez desde `main.tex` y ahí es donde se
busca cuando algo se rompe.

## Reglas que el documento ya asume

- `hyperref` y luego `cleveref` van **al final** de `packages.tex`. Un
  paquete nuevo se añade antes de ellos o el PDF pierde los enlaces.
- `\graphicspath` apunta a `figures/`, así que las imágenes se citan por
  nombre sin ruta ni extensión.
- Referencias siempre con `\cref{...}` y etiquetas con prefijo
  (`sec:`, `fig:`, `tab:`, `eq:`, `lst:`). Nunca escribas el número.
- Cifras con unidad vía `siunitx` (`\SI{32}{\giga\byte}`), que fija coma
  decimal y punto de millar para español.
- Tablas con `booktabs`, sin reglas verticales. Pie encima en tablas,
  debajo en figuras.
- Un término que aparezca más de dos veces se convierte en macro
  (`\pc`, `\comp`, `\precio`) para que no haya dos redacciones del mismo
  nombre.

## Al editar contenido

`sections/02-desarrollo.tex` es una plantilla de ejemplos, no contenido
real: contiene un caso de cada elemento (figura, tabla, ecuación,
listado) para copiar. La figura que trae es un `\fbox` de relleno porque
`figures/` está vacío.

Si añades un paquete nuevo, comprueba que está instalado antes de
asumirlo: `kpsewhich nombre.sty`. En Fedora se instala con
`sudo dnf install 'tex(nombre.sty)'`.
