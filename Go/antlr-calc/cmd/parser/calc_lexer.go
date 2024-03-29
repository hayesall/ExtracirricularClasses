// Code generated from Calc.g4 by ANTLR 4.7.2. DO NOT EDIT.

package parser

import (
	"fmt"
	"unicode"

	"github.com/antlr/antlr4/runtime/Go/antlr"
)

// Suppress unused import error
var _ = fmt.Printf
var _ = unicode.IsLetter

var serializedLexerAtn = []uint16{
	3, 24715, 42794, 33075, 47597, 16764, 15335, 30598, 22884, 2, 13, 56, 8,
	1, 4, 2, 9, 2, 4, 3, 9, 3, 4, 4, 9, 4, 4, 5, 9, 5, 4, 6, 9, 6, 4, 7, 9,
	7, 4, 8, 9, 8, 4, 9, 9, 9, 4, 10, 9, 10, 4, 11, 9, 11, 4, 12, 9, 12, 3,
	2, 3, 2, 3, 3, 3, 3, 3, 4, 3, 4, 3, 5, 3, 5, 3, 6, 3, 6, 3, 7, 3, 7, 3,
	8, 3, 8, 3, 9, 3, 9, 3, 10, 3, 10, 3, 10, 3, 11, 6, 11, 46, 10, 11, 13,
	11, 14, 11, 47, 3, 12, 6, 12, 51, 10, 12, 13, 12, 14, 12, 52, 3, 12, 3,
	12, 2, 2, 13, 3, 3, 5, 4, 7, 5, 9, 6, 11, 7, 13, 8, 15, 9, 17, 10, 19,
	11, 21, 12, 23, 13, 3, 2, 4, 3, 2, 50, 59, 5, 2, 11, 12, 15, 15, 34, 34,
	2, 57, 2, 3, 3, 2, 2, 2, 2, 5, 3, 2, 2, 2, 2, 7, 3, 2, 2, 2, 2, 9, 3, 2,
	2, 2, 2, 11, 3, 2, 2, 2, 2, 13, 3, 2, 2, 2, 2, 15, 3, 2, 2, 2, 2, 17, 3,
	2, 2, 2, 2, 19, 3, 2, 2, 2, 2, 21, 3, 2, 2, 2, 2, 23, 3, 2, 2, 2, 3, 25,
	3, 2, 2, 2, 5, 27, 3, 2, 2, 2, 7, 29, 3, 2, 2, 2, 9, 31, 3, 2, 2, 2, 11,
	33, 3, 2, 2, 2, 13, 35, 3, 2, 2, 2, 15, 37, 3, 2, 2, 2, 17, 39, 3, 2, 2,
	2, 19, 41, 3, 2, 2, 2, 21, 45, 3, 2, 2, 2, 23, 50, 3, 2, 2, 2, 25, 26,
	7, 42, 2, 2, 26, 4, 3, 2, 2, 2, 27, 28, 7, 43, 2, 2, 28, 6, 3, 2, 2, 2,
	29, 30, 7, 93, 2, 2, 30, 8, 3, 2, 2, 2, 31, 32, 7, 95, 2, 2, 32, 10, 3,
	2, 2, 2, 33, 34, 7, 44, 2, 2, 34, 12, 3, 2, 2, 2, 35, 36, 7, 49, 2, 2,
	36, 14, 3, 2, 2, 2, 37, 38, 7, 45, 2, 2, 38, 16, 3, 2, 2, 2, 39, 40, 7,
	47, 2, 2, 40, 18, 3, 2, 2, 2, 41, 42, 7, 44, 2, 2, 42, 43, 7, 44, 2, 2,
	43, 20, 3, 2, 2, 2, 44, 46, 9, 2, 2, 2, 45, 44, 3, 2, 2, 2, 46, 47, 3,
	2, 2, 2, 47, 45, 3, 2, 2, 2, 47, 48, 3, 2, 2, 2, 48, 22, 3, 2, 2, 2, 49,
	51, 9, 3, 2, 2, 50, 49, 3, 2, 2, 2, 51, 52, 3, 2, 2, 2, 52, 50, 3, 2, 2,
	2, 52, 53, 3, 2, 2, 2, 53, 54, 3, 2, 2, 2, 54, 55, 8, 12, 2, 2, 55, 24,
	3, 2, 2, 2, 5, 2, 47, 52, 3, 8, 2, 2,
}

var lexerDeserializer = antlr.NewATNDeserializer(nil)
var lexerAtn = lexerDeserializer.DeserializeFromUInt16(serializedLexerAtn)

var lexerChannelNames = []string{
	"DEFAULT_TOKEN_CHANNEL", "HIDDEN",
}

var lexerModeNames = []string{
	"DEFAULT_MODE",
}

var lexerLiteralNames = []string{
	"", "'('", "')'", "'['", "']'", "'*'", "'/'", "'+'", "'-'", "'**'",
}

var lexerSymbolicNames = []string{
	"", "LPAREN", "RPAREN", "LBRACK", "RBRACK", "MUL", "DIV", "ADD", "SUB",
	"EXP", "NUMBER", "WHITESPACE",
}

var lexerRuleNames = []string{
	"LPAREN", "RPAREN", "LBRACK", "RBRACK", "MUL", "DIV", "ADD", "SUB", "EXP",
	"NUMBER", "WHITESPACE",
}

type CalcLexer struct {
	*antlr.BaseLexer
	channelNames []string
	modeNames    []string
	// TODO: EOF string
}

var lexerDecisionToDFA = make([]*antlr.DFA, len(lexerAtn.DecisionToState))

func init() {
	for index, ds := range lexerAtn.DecisionToState {
		lexerDecisionToDFA[index] = antlr.NewDFA(ds, index)
	}
}

func NewCalcLexer(input antlr.CharStream) *CalcLexer {

	l := new(CalcLexer)

	l.BaseLexer = antlr.NewBaseLexer(input)
	l.Interpreter = antlr.NewLexerATNSimulator(l, lexerAtn, lexerDecisionToDFA, antlr.NewPredictionContextCache())

	l.channelNames = lexerChannelNames
	l.modeNames = lexerModeNames
	l.RuleNames = lexerRuleNames
	l.LiteralNames = lexerLiteralNames
	l.SymbolicNames = lexerSymbolicNames
	l.GrammarFileName = "Calc.g4"
	// TODO: l.EOF = antlr.TokenEOF

	return l
}

// CalcLexer tokens.
const (
	CalcLexerLPAREN     = 1
	CalcLexerRPAREN     = 2
	CalcLexerLBRACK     = 3
	CalcLexerRBRACK     = 4
	CalcLexerMUL        = 5
	CalcLexerDIV        = 6
	CalcLexerADD        = 7
	CalcLexerSUB        = 8
	CalcLexerEXP        = 9
	CalcLexerNUMBER     = 10
	CalcLexerWHITESPACE = 11
)
