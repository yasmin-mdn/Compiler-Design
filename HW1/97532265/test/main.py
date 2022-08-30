from antlr4 import *
from gen.CPP14Lexer import CPP14Lexer
from gen.CPP14Parser import CPP14Parser

if __name__ == '__main__':
  input_stream = FileStream("test.cpp")
  lexer = CPP14Lexer(input_stream)
  stream = CommonTokenStream(lexer)
  parser = CPP14Parser(stream)
  tree = parser.translationunit()
  print(tree)

