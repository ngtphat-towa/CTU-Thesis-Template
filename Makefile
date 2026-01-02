.PHONY: all watch clean help

# Detect OS
ifeq ($(OS),Windows_NT)
	RM = del /Q
else
	RM = rm -f
endif

all:
	typst compile main.typ thesis.pdf

watch:
	typst watch main.typ thesis.pdf

clean:
	$(RM) thesis.pdf

help:
	@echo CTU Thesis Makefile
	@echo   make         - Compile thesis
	@echo   make watch   - Watch and auto-compile
	@echo   make clean   - Remove PDF
