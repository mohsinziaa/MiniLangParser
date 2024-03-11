%{ 
/* Definition section */
#include<stdio.h> 
#include<string.h>
int flag = 0;
int assignmentFlag = 0;
int variables[26]; // Assuming only lowercase letters are used for variables
%} 

%token NUMBER
%token VARIABLE

%left '+' '-'
%left '*' '/' '%'
%left '(' ')'

/* Rule Section */
%% 

Statement: 
          | ArithmeticExpression { assignmentFlag = 0; }
          | Assignment { assignmentFlag = 1; }
          ;

ArithmeticExpression: E { 
        printf("\nResult=%d\n", $$); 
        return 0; 
    }; 

E: E '+' E { $$ = $1 + $3; } 
  | E '-' E { $$ = $1 - $3; } 
  | E '*' E { $$ = $1 * $3; } 
  | E '/' E { $$ = $1 / $3; } 
  | E '%' E { $$ = $1 % $3; } 
  | '(' E ')' { $$ = $2; } 
  | NUMBER { $$ = $1; } 
  | VARIABLE { $$ = variables[$1 - 'a']; } // Retrieve value of variable
  ; 

Assignment: VARIABLE '=' E { 
        variables[$1 - 'a'] = $3; // Assign value to variable
    };

%% 

//driver code 
int main() { 
    while (1) {
        printf("\nEnter any arithmetic operator or variable assignment: "); 
        yyparse(); 
                
        if (flag == 0) {
            if (assignmentFlag == 1)
                printf("\nEntered variable assignment is valid.\n\n");
            else
                printf("\nEntered arithmetic expression is valid.\n\n");
        }
    }
	return 0;
} 

void yyerror(char *msg) { 
    printf("\nEntered arithmetic expression is Invalid\n\n"); 
    flag = 1; 
}
