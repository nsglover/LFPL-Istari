
UNITS = \
	core/language core/substitution core/semantics \
	util/nfold util/math \
	tools/list tools/iteration tools/bit \
	non-size-inc/size non-size-inc/heap-free \
	completeness/machine completeness/encoding

all : $(foreach i, $(UNITS), $(i).isto $(i).ist)

%.isto : %.ist
	istari $<

clean :
	rm -f */*.isto
