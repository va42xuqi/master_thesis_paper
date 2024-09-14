# Makefile for building the thesis
#
# This Makefile tries to automatically track dependencies. You should not need
# to add .tex files to the list of dependencies. However, if you delete a file
# that has been included in the list of dependencies in a previous run, the
# make command may fail. To overcome this problem, simply type `make clean`.

# Configurations
THESIS_TEX=thesis.tex
REFERENCES=references.bib

# You should not need to touch the following:
THESIS_AUX=$(patsubst %.tex,%.aux,$(THESIS_TEX))
THESIS_PDF=$(patsubst %.tex,%.pdf,$(THESIS_TEX))
THESIS_FLS=$(patsubst %.tex,%.fls,$(THESIS_TEX))
THESIS_DEPS=dependencies.mk

-include $(THESIS_DEPS)



# Main targets
.PHONY: all clean distclean

all: $(THESIS_PDF)

clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.lst *.vrb *.off
	rm -f contents/*.aux
	rm -f $(THESIS_FLS)
	rm -f $(THESIS_DEPS)

distclean: clean
	rm -f $(THESIS_PDF)



# Internal targets
$(THESIS_PDF): $(THESIS_TEX) $(REFERENCES)
	@echo "1) Run pdflatex"
	@pdflatex -halt-on-error -file-line-error -record $(THESIS_TEX)
	@echo "2) Run bibtex"
	@bibtex $(THESIS_AUX)
	@echo "3) Run pdflatex"
	@pdflatex -halt-on-error -file-line-error -record -interaction-mode=batch $(THESIS_TEX)
	@echo "4) Run pdflatex"
	@pdflatex -halt-on-error -file-line-error -record -interaction-mode=batch $(THESIS_TEX)
	@echo -n "${THESIS_PDF}: " > ${THESIS_DEPS}
	@grep "^INPUT [^/]" $(THESIS_FLS) | grep -vE '(\.aux)|(\.nav)|(\.out)|(\.toc)|(\.vrb)$$' | sort | uniq | sed "s/INPUT //g" | paste -sd " " >> $(THESIS_DEPS)

# Of course, you may add here some targets which generate images etc. used in
# your thesis
