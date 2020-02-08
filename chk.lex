%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
select					{printf("\nKEYWORD SELECT\n");return SELECT;};
create					{printf("\nKEYWORD CREATE\n");return CREATE;};
table					{printf("\nKEYWORD TABLE\n");return TABLE;};
from					{printf("\nKEYWORD FROM\n");return FROM;};
in 					{printf("\nKEYWORD IN\n");return IN;};
where					{printf("\nKEYWORD WHERE\n");return WHERE;};
and					{printf("\nKEYWORD AND\n");return AND;};
update					{printf("\nKEYWORD UPDATE\n");return UPDATE;};
set					{printf("\nKEYWORD SET\n");return SET;};
delete					{printf("\nKEYWORD DELETE\n");return DELETE;};
group 					return GROUP;
by					return BY;
having					return HAVING;
order					return ORDER;
asc					return ASC;
desc					return DESC;
[*]					 return *yytext;
[,]					 return *yytext;
[=]					{printf("\nEquals Operator\n");return *yytext;};
[(]					 return *yytext;
[)]					 return *yytext;
[a-zA-Z][a-zA-Z0-9]*			{printf("\nIDENTIFIER\n");return IDENTIFIER;};
[0-9]+					return CONSTANT;
\n					return *yytext;
[ \t]+					/* ignore whitespace */;
%%
