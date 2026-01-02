.PHONY: all watch clean help

all:
	typst compile main.typ thesis.pdf

watch:
	typst watch main.typ thesis.pdf

clean:
	@if exist thesis.pdf del thesis.pdf

help:
	@echo CTU Thesis Makefile
	@echo   make         - Compile thesis
	@echo   make watch   - Watch and auto-compile
	@echo   make clean   - Remove PDF
