
UNITS = language semantics heapfree size

all : $(foreach i, $(UNITS), $(i).isto)

%.isto : %.ist
	istari $<

clean :
	rm -f *.isto
