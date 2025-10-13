define prepend
  $(foreach u, $(2), $(1)/$(u))
endef

UNITS = \
	$(call prepend, math, nfold poly div) \
	$(call prepend, machine, tape transition) \
	$(call prepend, lfpl/core, language substitution semantics) \
	$(call prepend, lfpl/lib/bool, sugar tools) \
	$(call prepend, lfpl/lib/list, sugar tools) \
	$(call prepend, lfpl/lib/nat, sugar tools memory) \
	$(call prepend, lfpl/lib/stack, interface weakened additive base inductive construction) \
	$(call prepend, lfpl/properties, size heap-free) \

.PHONY: all clean 

all : $(foreach i, $(UNITS), $(i).isto $(i).ist)

%.isto : %.ist
	istari $<

clean :
	find . -name "*.isto" -type f -delete