from antlr4 import *
from gen.JavaLexer import JavaLexer


def main():
    path = "test.java"
    input_stream = FileStream(path)
    lexer = JavaLexer(input_stream)
    stream = CommonTokenStream(lexer)
    token = lexer.nextToken()
    Uncomment = open("with_out_comment.java", "w")
    while token.type != Token.EOF:
        if token.type == lexer.COMMENT:
            Uncomment.write(token.text[2:len(token.text) - 2].rstrip("\n"))
        elif token.text[0] == '/' and token.text[1] == '/':
            Uncomment.write(token.text[2:len(token.text)].rstrip("\n"))
        else:
            Uncomment.write(token.text.rstrip("\n"))

        token = lexer.nextToken()


if __name__ == '__main__':
    main()
