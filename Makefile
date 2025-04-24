
UNITS = language substitution semantics sugar size heapfree

all : $(foreach i, $(UNITS), $(i).isto)

%.isto : %.ist
	istari $<

clean :
	rm -f *.isto
