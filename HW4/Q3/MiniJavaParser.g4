parser grammar MiniJavaParser;


options { tokenVocab=MiniJavaLexer; }

@parser::members
{
temp_counter = 0
goto_counter = 0
def create_goto(self):
    self.goto_counter += 1
    return 'L' + str(self.goto_counter)
def create_temp(self):
    self.temp_counter += 1
    return 'T' + str(self.temp_counter)
def remove_temp(self):
    self.temp_counter -= 1
def get_temp(self):
    return 'T' + str(self.temp_counter)
}

program
    : {print('\nTAC generated for statements:')} mainClass ( classDeclaration )* EOF
    ;

mainClass
    : CLASS identifier LBRACE PUBLIC STATIC VOID MAIN LPAREN STRING LBRACK RBRACK identifier RPAREN LBRACE s=statement RBRACE RBRACE
    {print($s.value_attr)}
    ;

classDeclaration
    : 'class' identifier ( 'extends' identifier )? '{' ( varDeclaration )* ( methodDeclaration )* '}'
    ;

varDeclaration
    : t=type_ i=identifier ';'
    ;

methodDeclaration
    : 'public' type_ identifier '(' ( type_ identifier ( ',' type_ identifier )* )? ')' '{' ( varDeclaration )* ( s=statement {print($s.value_attr)} )* 'return' expression ';' '}'
    ;

type_
    : 'int' '[' ']'
    | 'boolean'
    | 'int'
    | i=identifier
    ;


statement returns [value_attr = str(), type_attr = str(),old_value_attr = str()]
    :   '{'{$value_attr=''} ( s=statement {$value_attr=$value_attr+$s.value_attr+'\n'} )* '}'
    |  'if' '(' e=expression ')' s1=statement 'else' s2=statement
{goto1 = self.create_goto()}
{goto2 = self.create_goto()}
{for item in $e.temp_list:
    $value_attr = $value_attr + item + '\n'
    #print(item)}
{#print('\t\t'+'if (',$e.value_attr,') goto ',goto1)}
{$value_attr=$value_attr+'\t\t'+'if ('+$e.value_attr+') goto '+goto1+'\n'}
{#print($s2.value_attr,end='')}
{$value_attr = $value_attr + $s2.value_attr}
{#print('\t\t'+'goto ',goto2)}
{$value_attr= $value_attr+'\t\t'+'goto '+goto2+'\n'}
{#print(goto1,':',$s1.value_attr,end='')}
{$value_attr = $value_attr+goto1+':'+$s1.value_attr}
{#print(goto2,':\t\t',end='')}
{$value_attr= $value_attr + goto2+':\t\t'}
    | 'while' '(' e=expression ')' s=statement
{goto1 = self.create_goto()}
{goto2 = self.create_goto()}
{$value_attr= '\t\t'+'goto '+goto1+'\n'}
{$value_attr = $value_attr+goto2+':'+$s.value_attr}
{$value_attr= $value_attr + goto1+':'}
{for item in $e.temp_list:
    $value_attr = $value_attr + item + '\n'
    #print(item)}
{$value_attr=$value_attr+'\t\t'+'if ('+$e.value_attr+') goto '+goto2+'\n'}
    | 'System.out.println' '(' expression ')' ';'
    | i=identifier '=' e=expression ';'
{$value_attr = ''}
{for item in $e.temp_list:
    $value_attr=$value_attr+item+'\n'}
{$value_attr=$value_attr+'\t\t'+$i.value_attr +' = '+ $e.value_attr}
    | i=identifier '[' e1=expression ']' '=' e2=expression ';'
{$value_attr = ''}
{for item in $e1.temp_list:
    $value_attr=$value_attr+item+'\n'}
{for item in $e2.temp_list:
    $value_attr=$value_attr+item+'\n'}
{temp = self.create_temp()}
{$value_attr=$value_attr+'\t\t'+temp+ '='+'sizeOf('+ $i.value_attr+')\n'+'\t\t'+temp+ '='+temp+'*'+$e1.value_attr+'\n'+'\t\t'+temp+ '= &'+$i.value_attr+'+'+temp+'\n'+'\t\t'+'*'+ temp +' = '+ $e2.value_attr}
    ;

expression returns [value_attr = str(), type_attr = str(),old_value_attr = str(),temp_list = []]
    : e1=expression '&&' e2=expression
    {$type_attr = 'BOOL'}
    {$temp_list = $e1.temp_list}
    {if $e1.old_value_attr is not None:
        temp = self.create_temp()
        $temp_list.append('\t\t'+temp+'='+$e1.old_value_attr)
        #print('\t\t',temp, '=', $e1.old_value_attr)
        $e1.value_attr = temp}
    {$temp_list =$temp_list + $e2.temp_list}
    {if $e2.old_value_attr is not None:
        temp = self.create_temp()
        $temp_list.append('\t\t'+temp+'='+$e2.old_value_attr)
        #print('\t\t',temp, '=', $e2.old_value_attr)
        $e2.value_attr = temp}
    {$value_attr = $e1.value_attr + " && " + $e2.value_attr}
    {$old_value_attr = $e1.value_attr + " && " + $e2.value_attr}                #expression00
    | e1=expression '<' e2=expression
{$temp_list = $e1.temp_list}
{$type_attr = 'BOOL'}
{if $e1.old_value_attr is not None:
    temp = self.create_temp()
    $temp_list.append('\t\t'+temp+'='+$e1.old_value_attr)
    #print('\t\t',temp, '=', $e1.old_value_attr)
    $e1.value_attr = temp}
{$temp_list =$temp_list + $e2.temp_list}
{if $e2.old_value_attr is not None:
    temp = self.create_temp()
    $temp_list.append('\t\t'+temp+'='+$e2.old_value_attr)
    #print('\t\t',temp, '=', $e2.old_value_attr)
    $e2.value_attr = temp}
{$value_attr = $e1.value_attr + " < " + $e2.value_attr}
{$old_value_attr = $e1.value_attr + " < " + $e2.value_attr}                 #expression02

    | e1=expression '+' e2=expression
    {$temp_list = $e1.temp_list}
    {$type_attr = 'INT'}
    {if $e1.old_value_attr is not None:
        temp = self.create_temp()
        $temp_list.append('\t\t'+temp+'='+$e1.old_value_attr)
        #print('\t\t',temp, '=', $e1.old_value_attr)
        $e1.value_attr = temp}
    {$temp_list =$temp_list + $e2.temp_list}
    {if $e2.old_value_attr is not None:
        temp = self.create_temp()
        $temp_list.append('\t\t'+temp+'='+$e2.old_value_attr)
        #print('\t\t',temp, '=', $e2.old_value_attr)
        $e2.value_attr = temp}
    {$value_attr = $e1.value_attr + " + " + $e2.value_attr}
    {$old_value_attr = $e1.value_attr + " + " + $e2.value_attr}                 #expression03
    | e1=expression '-' e2=expression
    {$temp_list = $e1.temp_list}
    {$type_attr = 'INT'}
    {if $e1.old_value_attr is not None:
        temp = self.create_temp()
        $temp_list.append('\t\t'+temp+'='+$e1.old_value_attr)
        #print('\t\t',temp, '=', $e1.old_value_attr)
        $e1.value_attr = temp}
    {$temp_list =$temp_list + $e2.temp_list}
    {if $e2.old_value_attr is not None:
        temp = self.create_temp()
        $temp_list.append('\t\t'+temp+'='+$e2.old_value_attr)
        #print('\t\t',temp, '=', $e2.old_value_attr)
        $e2.value_attr = temp}
    {$value_attr = $e1.value_attr + " - " + $e2.value_attr}
    {$old_value_attr = $e1.value_attr + " - " + $e2.value_attr}                 #expression04
    | e1=expression '*' e2=expression
    {$temp_list = $e1.temp_list}
    {$type_attr = 'INT'}
    {if $e1.old_value_attr is not None:
        temp = self.create_temp()
        $temp_list.append('\t\t'+temp+'='+$e1.old_value_attr)
        #print('\t\t',temp, '=', $e1.old_value_attr)
        $e1.value_attr = temp}
    {$temp_list =$temp_list + $e2.temp_list}
    {if $e2.old_value_attr is not None:
        temp = self.create_temp()
        $temp_list.append('\t\t'+temp+'='+$e2.old_value_attr)
        #print('\t\t',temp, '=', $e2.old_value_attr)
        $e2.value_attr = temp}
    {$value_attr = $e1.value_attr + " * " + $e2.value_attr}
    {$old_value_attr = $e1.value_attr + " * " + $e2.value_attr}                 #expression01
    | e1=expression '[' e2=expression ']'
    {$temp_list = $e1.temp_list}
    {$temp_list =$temp_list + $e2.temp_list}
    {$type_attr = 'INT'}
    {if $e1.old_value_attr is not None:
        print('\t\t','Semantic error in '+$e1.value_attr+' : only Arrays are itratable!')}
    {if $e2.old_value_attr is not None:
        temp = self.create_temp()
        $temp_list.append('\t\t'+temp+'='+$e2.old_value_attr)
        #print('\t\t',temp, '=', $e2.old_value_attr)
        $e2.value_attr = temp}
    {temp = self.create_temp()}
    {$temp_list.append('\t\t'+temp+ '='+'sizeOf('+ $e1.value_attr+')')}
    {$temp_list.append('\t\t'+temp+ '='+temp+'*'+$e2.value_attr)}
    {$temp_list.append('\t\t'+temp+ '= &'+$e1.value_attr+'+'+temp)}
    {$value_attr = '*'+temp}
    {$old_value_attr = '*'+temp}                                                #expression1
    | e=expression '.' 'length'
    {$temp_list = $e.temp_list}
    {$type_attr = 'INT'}
    {if $e.old_value_attr is not None:
        temp = self.create_temp()
        $temp_list.append('\t\t'+temp+'='+$e.old_value_attr)
        #print('\t\t',temp, '=', $e.old_value_attr)
        $e.value_attr = temp}
    {$value_attr = $e.value_attr + ".length "}
    {$old_value_attr = $e.value_attr + ".length "}                              #expression2
    | expression '.' identifier '(' ( expression ( ',' expression )* )? ')'
    {# Function call is not TAC convertable! or is it? don't know don't care!}  #expression3
    | INTEGER_LITERAL
{
$type_attr = 'INT'
$value_attr = $INTEGER_LITERAL.text
$old_value_attr = None
}                                                                               #expression4
    | 'true'
{
$type_attr = 'BOOL'
$value_attr = 'true'
$old_value_attr = None
}                                                                               #expression5
    | 'false'
{
$type_attr = 'BOOL'
$value_attr = 'false'
$old_value_attr = None
}                                                                               #expression6
    | i=identifier
{
if $i.type_attr != 'UNKOWN':
    print('Semantic error in "'+$i.value_attr+'" Identifier: "'+$i.value_attr+'" is not Declared!')
else:
    $type_attr = $i.type_attr
    $value_attr = $i.value_attr
    $old_value_attr = None
}                                                                               #expression7
    | 'this'
{# object reference is not TAC convertable! or is it? don't know don't care!}   #expression8
    | 'new' 'int' '[' expression ']'
{# initialization is not TAC convertable! or is it? don't know don't care!}     #expression9
    | 'new' identifier '(' ')'
{# initialization is not TAC convertable! or is it? don't know don't care!}     #expression10
    | '!' e=expression
    {$temp_list = $e.temp_list}
    {$type_attr = 'BOOL'}
    {if $e.old_value_attr is not None:
        temp = self.create_temp()
        $temp_list.append('\t\t'+temp+'='+$e.old_value_attr)
        #print('\t\t',temp, '=', $e.old_value_attr)
        $e1.value_attr = temp}
    {$value_attr = '!'+$e.value_attr}
    {$old_value_attr = '!'+$e.value_attr}                                       #expression11

    |'(' e=expression ')'
    {$type_attr = $e.type_attr}
    {$value_attr = $e.value_attr}
    {$old_value_attr = $e.old_value_attr}
    {$temp_list = $e.temp_list}                                        #expression12
    ;

identifier returns [value_attr = str(), type_attr = str()]
    : IDENTIFIER
{
$value_attr = $IDENTIFIER.text
$type_attr = 'UNKOWN'
}
    ;