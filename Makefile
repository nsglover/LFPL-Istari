define prepend
  $(foreach u, $(2), $(1)/$(u))
endef

UNITS = \
	$(call prepend, math, nfold div exp binom poly) \
	$(call prepend, machine, tape transition) \
	$(call prepend, lfpl/core, language substitution semantics) \
	$(call prepend, lfpl/lib/heap-free, sugar complete) \
	$(call prepend, lfpl/lib/list, sugar tools) \
	$(call prepend, lfpl/lib/nat, sugar tools memory) \
	$(call prepend, lfpl/lib/stack, interface weakened additive base inductive construction) \
	$(call prepend, lfpl/soundness, size) \
	$(call prepend, lfpl/completeness, ) \

.PHONY: all clean 

all : $(foreach i, $(UNITS), $(i).isto $(i).ist)

%.isto : %.ist
	istari $<

clean :
	find . -name "*.isto" -type f -delete