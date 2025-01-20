DAT=$(wildcard *.dat)
PPN=$(patsubst %.dat,%.ppn,$(DAT))
PP=$(patsubst %.dat,%.pp,$(DAT))

all: $(PPN) $(PP) stats.csv

stats.csv: $(PPN)	
	./stats.sh > stats.csv

%.ppn: %.dat
	picadata get -f norm '003@$$0' $< > $@

%.pp: %.dat
	picadata -f norm -t plain $< > $@
