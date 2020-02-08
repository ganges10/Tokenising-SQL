%{
#include <stdio.h>
void yyerror (const char *str);
int yylex(void);
%}


%token SELECT FROM IDENTIFIER WHERE AND CREATE TABLE UPDATE SET DELETE IN GROUP BY HAVING ORDER ASC DESC CONSTANT;
%start line
%%
select: SELECT;
items: '*' | identifiers;
table: FROM IDENTIFIER;
using: 
     | WHERE condition;
condition: IDENTIFIER '=' IDENTIFIER | IDENTIFIER '=' CONSTANT | IDENTIFIER '=' IDENTIFIER AND condition;
      
line: selection '\n' {printf("\nValid Syntax\n");}
      | create tablename '\n' {printf("\nSyntax Valid\n");}
      | update tablename set columns using condition '\n' {printf("\nSyntax Valid\n");}
      | delete table using condition '\n' {printf("\nSyntax Valid\n");};
selection:select items table using
      |select items table using groupby orderby 
      |select items table WHERE identifiers in selection
      |select items table WHERE IDENTIFIER '=' equals ;  
update:UPDATE;
equals: '(' selection ')';
set:SET;
groupby:
       | GROUP BY col having ;

col:IDENTIFIER ',' col | IDENTIFIER;
having:
      | HAVING condition ;
orderby:
       | ORDER BY col ord;
ord:
   | ASC | DESC;
in:IN;
columns:IDENTIFIER '=' IDENTIFIER | IDENTIFIER '=' IDENTIFIER ',' columns;
delete:DELETE;
create:CREATE TABLE;
tablename:IDENTIFIER;
identifiers: IDENTIFIER | IDENTIFIER ',' identifiers;
%%


void yyerror (const char *str) {
	fprintf(stderr, "error: %s\n", str);
}

int yywrap(void){return 1;}

int main() {
	yyparse();
	return 0;
}
