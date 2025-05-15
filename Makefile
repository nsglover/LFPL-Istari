
UNITS = math language substitution semantics sugar size heapfree utility machine completeness

all : $(foreach i, $(UNITS), $(i).isto $(i).ist)

%.isto : %.ist
	istari $<

clean :
	rm -f *.isto
