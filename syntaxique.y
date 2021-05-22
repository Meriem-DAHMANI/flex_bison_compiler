%{  
    #include <stdio.h>
    int yylex();
    int yyerror();

    int nb_ligne=1, Col=1;
    char* sauvType;
    int processdec=0, loopdec=0,arraydec=0;
%}

%union {
         int     entier;
         char*   str;
         float reel;
}


%token mc_pgm mc_process mc_loop mc_array mc_var mc_entier mc_real mc_char mc_str mc_const mc_read mc_write <str>IDF  <entier>entier <reel>reel chaine car  boucw conEG conInf conSup condInforEg condSuporEg conddiff adr mc_execut conddeb condtrai condfin fin dpts sep bib egale aff add multi sous dev accv accf crov crof formIng formReal formStr formChar form parv parf commdeb comfin g gg 
%start S

%%
S: LIST_BIB  mc_pgm  IDF  accv DEC_VAR SUITE_INSTS accf {printf("syntaxe correcte");YYACCEPT;}
;

cst: entier 
    |reel
    |parv add entier parf 
    |parv sous entier parf 
    |parv add reel parf 
    |parv sous reel parf 
;

cstU : parv add entier parf 
     |parv sous entier parf 
     |parv add reel parf 
     |parv sous reel parf 
;


LIST_BIB : LIST_BIB BIB  
         |
;
BIB: bib NOM_BIB fin
;
NOM_BIB : mc_process {processdec=1;}
        | mc_loop {loopdec=1;}
        |mc_array {arraydec=1;}
;

DEC_VAR:mc_var LIST_DEC DEC_VAR
       |mc_const LIST_CONST DEC_VAR
       |
;


LIST_DEC: TYPE dpts SUITE_IDF fin LIST_DEC 
          |
;
SUITE_IDF: VARDEC sep SUITE_IDF
          |VARDEC
;
VARDEC : IDF {if(doubleDeclaration($1)==0)
            insererTYPE($1,sauvType);
            else
            printf("err semantique: double declaration de %s a la ligne %d\n",$1,nb_ligne);
}
         |IDF crov cst crof {if(doubleDeclaration($1)==0)
            insererTYPE($1,sauvType);
            else
            printf("err semantique: double declaration de %s a la ligne %d\n",$1,nb_ligne);
 
 if (arraydec==0)  printf("err semantique: bibliothèque array non declarée a ligne %d et a la colonne %d: division par 0 \n", nb_ligne,Col);
            

}
;
LIST_CONST: TYPE dpts SUITE_CONST fin LIST_CONST
          |
;
SUITE_CONST : VARDEC aff VAL sep SUITE_CONST
            | VARDEC aff VAL 

;
VAL : cst
    | g chaine g
    | gg car gg
;

TYPE:mc_entier
      |mc_real
      |mc_char
      |mc_str
;

SUITE_INSTS: INST SUITE_INSTS
             |
;

INST : SUITE_AFF {if (processdec==0)  printf("err semantique: bibliothèque process non declarée a ligne %d et a la colonne %d: division par 0 \n", nb_ligne,Col); }
        |E
        |S
        |BOUCLE {if (loopdec==0)  printf("err semantique: bibliothèque loop non declarée a ligne %d et a la colonne %d: division par 0 \n", nb_ligne,Col); }
        |CONDITION
;

SUITE_AFF:SUITE_AFF AFF fin
         |
;

AFF : IDF aff VALAFF {if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);
}
 
VALAFF : IDF  {if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);
}
 
         |VAL
         |INSTR 
;


INSTR : IDF OP IDF SUITINS {if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);

           if(nonDeclaree($3)==-1)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$3, nb_ligne,Col);
}
       |IDF OP cst SUITINS {if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);
}
       |cst OP cst SUITINS 
       |cst OP IDF SUITINS {if(nonDeclaree($3)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$3, nb_ligne,Col);
}
       |IDF OP IDF {if(nonDeclaree($3)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$3, nb_ligne,Col);
}
       |IDF OP cst {if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);
}
       |cst OP cst 
       |cst OP IDF  {if(nonDeclaree($3)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$3, nb_ligne,Col);
}
       |cst 
       |IDF {if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);
}

       |IDF dev IDF SUITINS  {if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);
        if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declarée aa ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);
        if(nonDeclaree($3)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$3, nb_ligne,Col);
}
       |IDF dev cstU SUITINS {if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);
        if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);
}
       |IDF dev entier SUITINS {
                                  if ($3==0) printf(" Erreur  semantique a ligne %d a la colonne %d: division par 0 \n", nb_ligne,Col);                                   
                                  else  printf("la Division de %s par %d \n ", $1,$3);      
                                if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declaréea ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);   
          
                             }
       |cst dev cstU SUITINS
       |cst dev entier SUITINS {
                                  if ($3==0) printf(" Erreur  semantique a ligne %d a la colonne %d: division par 0 \n", nb_ligne,Col);                                           
          
                             }
       |cst dev IDF SUITINS IDF {if(nonDeclaree($3)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$3, nb_ligne,Col);
}
       |IDF dev IDF IDF {if(nonDeclaree($3)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$3, nb_ligne,Col);
}
       |IDF dev cstU IDF {if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declarée a ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);
}
       |IDF dev entier {if(nonDeclaree($1)!=0)
           printf("err semantique: variable %s non declarée  a ligne %d et a la colonne %d: division par 0 \n",$1, nb_ligne,Col);
}                                  
                                   
       |cst dev cstU
       |cst dev entier {
                                  if ($3==0) printf(" Erreur  semantique a ligne %d et a la colonne %d: division par 0 \n", nb_ligne,Col);                                   
                                  }
       |cst dev IDF  {if(nonDeclaree($3)!=0)
           printf("err semantique: variable %s non declarée a la ligne %d\n",$3,nb_ligne);
}
           
;
SUITINS : OP INSTR
         |dev cst 
         |dev entier {
                                  if ($2==0) printf(" Erreur  semantique a ligne %d et a la colonne %d: division par 0 \n", nb_ligne,Col);                                            
          
                             }
         |dev IDF 

;

OP: add
   |multi
   |sous
; 

E : mc_read parv g SIGF g form adr IDF parf;

SIGF: formIng
    | formReal
    | formStr
    | formChar
;

S: mc_write parv g PHRASE g form liste_IDF parf 
;

PHRASE : chaine PHRASE 
       | chaine
;

liste_IDF : IDF sep liste_IDF 
          |IDF
;

BOUCLE : boucw  COND  accv SUITE_INSTS accf fin
;

COND : parv INSTR OPECOMP INSTR parf
;

OPECOMP :conEG
		|conInf
		|conSup
		|condInforEg
		|condSuporEg
		|conddiff
;

CONDITION : mc_execut INST conddeb COND SUITE condfin fin
;

SUITE:condtrai mc_execut SUITE_INSTS
           |

;

%%

int main()
{
     initialisation();
     yyparse();
     afficher();
     return 0;

}

int yywrap()
{
return 0;
}
int yyerror(char *msg)
{ printf ("Erreur Syntaxique a ligne %d a colonne %d \n", nb_ligne,Col);
return 1; }

	

