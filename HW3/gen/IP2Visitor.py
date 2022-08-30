# Generated from E:/uni/term6/compiler/3\IP2.g4 by ANTLR 4.9.1
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .IP2Parser import IP2Parser
else:
    from IP2Parser import IP2Parser

# This class defines a complete generic visitor for a parse tree produced by IP2Parser.

class IP2Visitor(ParseTreeVisitor):

    # Visit a parse tree produced by IP2Parser#start.
    def visitStart(self, ctx:IP2Parser.StartContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by IP2Parser#host.
    def visitHost(self, ctx:IP2Parser.HostContext):
        return self.visitChildren(ctx)



del IP2Parser