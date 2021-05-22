%{
#include "syntaxique.tab.h"
#include <stdlib.h>
#include <string.h>
 #include "ts.h"
extern int nb_ligne;
extern int Col;
extern YYSTYPE yylval;
%}
lettre [a-zA-Z]
chiffre [0-9]
lettreM [A-Z]
IDF {lettreM}({lettre}|{chiffre})*
entier [0-9]+ 
reel (0|[1-9][0-9]*)"\."[0-9]*[1-9]
chaine ({lettre}|{chiffre})({lettre}|{chiffre})+
car {lettre}
cmnt "/*"[^*\/]*"*/"
%%
Programme { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_pgm;}
PROCESS { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_process;}
LOOP {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_loop;  }
ARRAY  {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_array;  }
VAR {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_var;  }
INTEGER {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_entier;  }
REAL {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_real;  }
CHAR {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_char;  }
STRING {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_str;  }
CONST {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_const;  }
READ  {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_read;  }
WRITE  {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_write;  }
WHILE  {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return  boucw;  }
EG  {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return conEG;  }
INF {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return conInf;  }
SUP {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return conSup;  }
INFE {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return condInforEg;  }
SUPE {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return condSuporEg;  }
DIFF {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return conddiff;  }
@ {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return adr;  }
EXECUT {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_execut;  }
IF {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return conddeb;  }
ELSE {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return condtrai;  }
END_IF {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return condfin;  }

{IDF} {yylval.str=strdup(yytext);
			  rechercher(yytext,"IDF"," ",0,0);  
              Col= Col + strlen(yytext);
			  if (yyleng>10) printf ("Erreur Lexical: IDF trop long a la ligne %d a la colonne %d \n ",nb_ligne, Col);
              printf (" L entite lexicale reconnue est %s \n", yytext); 

			  return IDF;
		  }
{entier}     { 
              yylval.entier=atoi(yytext);
              rechercher(yytext,"Cst entier","INTEGER",atoi(yytext),0); 
			  Col= Col + strlen(yytext); 
			  printf (" L entite lexicale reconnue est %s \n", yytext);
			  if(atoi(yytext)>32767) printf ("Erreur Lexical: int trop grand a la ligne %d a la colonne %d \n ",nb_ligne, Col);
			  return entier;

		  }
{reel}     { 
              yylval.entier=atoi(yytext);
              rechercher(yytext,"Cst reel","REEL",atof(yytext),0); 
			  Col= Col + strlen(yytext); 
			  printf (" L entite lexicale reconnue est %s \n", yytext);
			  if(atof(yytext)>32767) printf ("Erreur Lexical: int trop grand a la ligne %d a la colonne %d \n ",nb_ligne, Col);
			  return reel;
		  }
{chaine}     { 
              yylval.str=strdup(yytext);
			  rechercher(yytext,"STR","STRING",0,0);  
              Col= Col + strlen(yytext);
              printf (" L entite lexicale reconnue est %s \n", yytext); 
			  return chaine;
		  }
{car}     { 
              yylval.str=strdup(yytext);
			  rechercher(yytext,"CAR","CHAR",0,0);  
              Col= Col + strlen(yytext);
              printf (" L entite lexicale reconnue est %s \n", yytext); 
			  return car;
		  }
{cmnt}

"$" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return fin;}
"/" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return dev;}
"::" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return dpts;}
"//" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return sep;}
"##" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return bib;}
"="  { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return egale;}
":=" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return aff;}
"+" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return add;}
"*" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return multi;}
"-" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return sous;}
"{" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return accv;}
"}" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return accf;}
"[" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return crov;}
"]" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return crof;}
";" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return formIng;}
"%" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return formReal;}
"?" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return formStr;}
"&" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return formChar;}
"|" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return form;}
"(" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return parv;}
")" { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return parf;} 
["] { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return g;}
['] { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return gg;}

. printf ("Entité lexicale non reconnue a ligne %d a la colonne %d \n", nb_ligne, Col);












