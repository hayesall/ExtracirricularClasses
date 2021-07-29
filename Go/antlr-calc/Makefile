# Copyright 2021 Alexander L. Hayes

.PHONY : clean

cmd/antlr-calc: cmd/parser
	cd cmd; go build .

cmd/parser: cmd/Calc.g4
	cd cmd; antlr4 -Dlanguage=Go -o parser Calc.g4

clean:
	rm -rf cmd/parser
