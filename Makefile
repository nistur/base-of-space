.phony: all BFG BFG-GW ABS

all: BFG BFG-GW ABS

BFG:
	./build.sh $@
BFG-GW:
	./build.sh $@
ABS:
	./build.sh $@