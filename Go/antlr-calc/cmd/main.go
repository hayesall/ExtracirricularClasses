// main.go
package main

import (
	"fmt"
	"io/ioutil"
	"log"

	"github.com/hayesall/ExtracirricularClasses/Go/antlr-calc/parser"

	"github.com/antlr/antlr4/runtime/Go/antlr"
)

type calcListener struct {
	*parser.BaseCalcListener
}

func main() {

	content, err := ioutil.ReadFile("input.txt")
	if err != nil {
		log.Fatal(err)
	}

	text := string(content)
	fmt.Println(text)

	is := antlr.NewInputStream(text)

	lexer := parser.NewCalcLexer(is)
	stream := antlr.NewCommonTokenStream(lexer, antlr.TokenDefaultChannel)

	p := parser.NewCalcParser(stream)
	antlr.ParseTreeWalkerDefault.Walk(&calcListener{}, p.Start())
}
