
UNITS = language semantics

all : $(foreach i, $(UNITS), $(i).isto)

%.isto : %.ist
	istari $<

clean :
	rm -f *.isto
