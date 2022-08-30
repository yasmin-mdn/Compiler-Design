from antlr4 import *
from gen.JavaParser import JavaParser
from gen.JavaLexer import JavaLexer
from gen.JavaParserLabeled import JavaParserLabeled
from gen.JavaParserLabeledListener import JavaParserLabeledListener
import os


def get_java_files(directory):
    """
    A generator that gives you all java files (*.java) in a specific directory.
    :param directory: The directory's absolute path you want to traverse.
    :return: Yields a *.java that exists in the directory
    """
    if not os.path.isdir(directory):
        raise ValueError("directory should be an absolute path of a directory!")
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.split('.')[-1] == 'java':
                yield os.path.join(root, file)


def printlist(ls):
    for t in ls:
        print(t, " ", end="")


className = []
methods = []
variables = []


class MyListener(JavaParserLabeledListener):
    def enterClassDeclaration(self, ctx: JavaParserLabeled.ClassDeclarationContext):
        className.append(ctx.IDENTIFIER())

    def enterVariableDeclaratorId(self, ctx: JavaParserLabeled.VariableDeclaratorIdContext):
        variables.append(ctx.IDENTIFIER())

    def enterMethodDeclaration(self, ctx: JavaParserLabeled.MethodDeclarationContext):
        methods.append(ctx.IDENTIFIER())

    def exitCompilationUnit(self, ctx: JavaParserLabeled.CompilationUnitContext):
        print("classNames:", end="")
        printlist(className)
        print("\t", end="")
        print("variables:", end="")
        printlist(variables)
        print("\t", end="")
        print("methods:", end="")
        printlist(methods)
        print("\n")


if __name__ == '__main__':
    for i in get_java_files("E:\\uni\\term6\\compiler\\2\\test_project\\src\\test\\java\\com\\jsoniter"):
        print(i, "\n")
        path = i
        input_stream = FileStream(path)
        lexer = JavaLexer(input_stream)
        stream = CommonTokenStream(lexer)
        parser = JavaParser(stream)
        tree = parser.compilationUnit()
        walker = ParseTreeWalker()
        walker.walk(MyListener(), tree)
