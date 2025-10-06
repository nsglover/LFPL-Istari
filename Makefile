
UNITS = \
	util/nfold util/poly util/list \
	core/language core/substitution core/semantics \
	sugar/list sugar/bit sugar/memory \
	stack/interface stack/base stack/inductive \
	completeness/iteration completeness/machine completeness/encoding \
	non-size-inc/size non-size-inc/heap-free

all : $(foreach i, $(UNITS), $(i).isto $(i).ist)

%.isto : %.ist
	istari $<

clean :
	rm -f */*.isto
