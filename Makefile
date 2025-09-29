
UNITS = \
	core/language core/substitution core/semantics \
	util/nfold util/math \
	tools/list tools/bit tools/memory \
	stack/interface stack/base stack/inductive \
	non-size-inc/size non-size-inc/heap-free \
	completeness/iteration completeness/machine completeness/encoding

all : $(foreach i, $(UNITS), $(i).isto $(i).ist)

%.isto : %.ist
	istari $<

clean :
	rm -f */*.isto
