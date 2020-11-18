H**************** CONTROL ***************               
H dftactgrp(*no) main(mainprog)                         
H**************** PROTOTYPES ***************            
Dmainprog         pr                  extpgm('TRNUPR00')
D                                2p 0                   
DisEven           pr                                    
D                                2s 0                   
DisPrime          pr                                    
D                                2s 0                   
Dfactorial        pr                                    
D                                2s 0                   
D**************** MAIN PROGRAM ***************          
Pmainprog         b                                     
D*** MAIN PARAMETERS *** //To recive external parameters
D                 pi                                    
DwwParm                          2p 0                   
D*** INTERNAL VARIABLES ***                             
DwwNum            s              2s 0                   
D***                                                    
  //dsply wwParm;                                       
  dsply '-------------';                                
  wwNum = 7 ; //Uses numbers between 0 and 99           
  callp isEven(wwNum);                                  
  callp isPrime(wwNum);                                 
  callp factorial(wwNum);                               
Pmainprog         e                                     
P**************** MAIN PROGRAM END ***************      
P**************** PROCEDURES ***************            
PisEven           b                                     
  // Parameter                                          
D                 pi                                    
DpiNum                           2s 0                   
D***                                                    
   if %rem(piNum:2) = 0;                                
     dsply (%char(piNum) + ' is even');                 
   else;                                                
     dsply (%char(piNum) + ' is odd');                  
   endif;                                               
PisEven           e                                     
P*****************                                      
PisPrime          b                                     
  // Parameter                                          
D                 pi                                    
DpiNum                           2s 0                   
  // Internal variables                                 
DyyCont           s              2s 0                   
DyyFlag           s              1s 0                   
D*                                                      
   yyCont = 2;                                          
   yyFlag = 1;                                          
   for yyCont to piNum;                                 
     if %rem(piNum:yyCont) = 0;                         
       yyFlag = 0;                                      
       leave;                                           
     endif;                                             
   endfor;                                              
   if yyFlag = 1;                                       
     dsply (%char(piNum) + ' is a prime number');       
   else;                                                
     dsply (%char(piNum) + ' is not a prime number');   
   endif;                                               
PisPrime          e                                     
P*****************                                      
Pfactorial        b                                     
  // Parameter                                          
D                 pi                                    
DpiNum                           2s 0                   
  // Internal variables                                 
DzzCont           s              2s 0                   
DzzResult         s             15s 0                   
   if piNum > 0 and piNum < 11;                         
       zzCont = 1 ;                                     
       zzResult = 1;                                    
     for zzCont to piNum;                               
       zzResult = zzResult * zzCont;                    
     endfor;                                            
     dsply (%char(piNum) + '! is ' + %char(zzResult));  
   else;                                                
     dsply 'Number to big or negative';                 
   endif;                                               
Pfactorial        e                                     
C*2020/11/11