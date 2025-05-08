
UNITS = language substitution semantics sugar util size heapfree

all : $(foreach i, $(UNITS), $(i).isto $(i).ist)

%.isto : %.ist
	istari $<

clean :
	rm -f *.isto
