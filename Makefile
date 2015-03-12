OCAMLMAKEFILE = OCamlMakefile

RESULT = hashcode
#SOURCES = $(wildcard src/*.ml)
SOURCES = \
	src/server.ml \
	src/parser.ml

OCAMLDOCFLAGS = -charset utf-8

include $(OCAMLMAKEFILE)

