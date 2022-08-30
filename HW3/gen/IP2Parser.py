# Generated from E:/uni/term6/compiler/3\IP2.g4 by ANTLR 4.9.1
# encoding: utf-8
from antlr4 import *
from io import StringIO
import sys
if sys.version_info[1] > 5:
	from typing import TextIO
else:
	from typing.io import TextIO


def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\5")
        buf.write("\20\4\2\t\2\4\3\t\3\3\2\3\2\3\2\3\3\3\3\3\3\3\3\3\3\3")
        buf.write("\3\3\3\2\2\4\2\4\2\2\2\r\2\6\3\2\2\2\4\t\3\2\2\2\6\7\5")
        buf.write("\4\3\2\7\b\7\2\2\3\b\3\3\2\2\2\t\n\7\3\2\2\n\13\7\5\2")
        buf.write("\2\13\f\7\4\2\2\f\r\7\5\2\2\r\16\7\4\2\2\16\5\3\2\2\2")
        buf.write("\2")
        return buf.getvalue()


class IP2Parser ( Parser ):

    grammarFileName = "IP2.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ "<INVALID>", "<INVALID>", "<INVALID>", "'.'" ]

    symbolicNames = [ "<INVALID>", "FirstTwo", "Octet", "Dot" ]

    RULE_start = 0
    RULE_host = 1

    ruleNames =  [ "start", "host" ]

    EOF = Token.EOF
    FirstTwo=1
    Octet=2
    Dot=3

    def __init__(self, input:TokenStream, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.9.1")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None




    class StartContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def host(self):
            return self.getTypedRuleContext(IP2Parser.HostContext,0)


        def EOF(self):
            return self.getToken(IP2Parser.EOF, 0)

        def getRuleIndex(self):
            return IP2Parser.RULE_start

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterStart" ):
                listener.enterStart(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitStart" ):
                listener.exitStart(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitStart" ):
                return visitor.visitStart(self)
            else:
                return visitor.visitChildren(self)




    def start(self):

        localctx = IP2Parser.StartContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_start)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 4
            self.host()
            self.state = 5
            self.match(IP2Parser.EOF)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class HostContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def FirstTwo(self):
            return self.getToken(IP2Parser.FirstTwo, 0)

        def Dot(self, i:int=None):
            if i is None:
                return self.getTokens(IP2Parser.Dot)
            else:
                return self.getToken(IP2Parser.Dot, i)

        def Octet(self, i:int=None):
            if i is None:
                return self.getTokens(IP2Parser.Octet)
            else:
                return self.getToken(IP2Parser.Octet, i)

        def getRuleIndex(self):
            return IP2Parser.RULE_host

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterHost" ):
                listener.enterHost(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitHost" ):
                listener.exitHost(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitHost" ):
                return visitor.visitHost(self)
            else:
                return visitor.visitChildren(self)




    def host(self):

        localctx = IP2Parser.HostContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_host)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 7
            self.match(IP2Parser.FirstTwo)
            self.state = 8
            self.match(IP2Parser.Dot)
            self.state = 9
            self.match(IP2Parser.Octet)
            self.state = 10
            self.match(IP2Parser.Dot)
            self.state = 11
            self.match(IP2Parser.Octet)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx





