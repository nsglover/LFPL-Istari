
UNITS = language substitution semantics sugar size heapfree math utility

all : $(foreach i, $(UNITS), $(i).isto $(i).ist)

%.isto : %.ist
	istari $<

clean :
	rm -f *.isto
