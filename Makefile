# Make does not offer a recursive wildcard function, so here's one:
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*), $(call rwildcard,$d/,$2))

ALL_SOURCES := $(call rwildcard,./,*.tex)
ALL_PDFS:= $(patsubst %.tex, %.pdf, ${ALL_SOURCES})

all: ${ALL_PDFS}

AUX_EXTS:= aux|nav|snm|log|toc|vrb|dvi|idx|fdb_latexmk|fls|out|ilg|ind


%.pdf: %.tex
		latexmk -pdf -pdflatex="pdflatex -interactive=nonstopmode" -use-make -cd  $<
		find $(dir $<) -maxdepth 1 -regextype posix-extended -regex '.*\.(${AUX_EXTS})' -delete

clean:
		find . -name '*.pdf' -delete
