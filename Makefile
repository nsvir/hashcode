OCAMLMAKEFILE = OCamlMakefile

RESULT = hashcode
#SOURCES = $(wildcard src/*.ml)
SOURCES = \
	src/server.ml \
	src/slot.ml \
	src/center.ml \
	src/parser.ml \
	src/flush.ml \
	src/main.ml \
	src/phase2.ml


OCAMLDOCFLAGS = -charset utf-8

include $(OCAMLMAKEFILE)

