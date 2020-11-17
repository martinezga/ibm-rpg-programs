H**************** CONTROL ***************                  
H dftactgrp(*no) main(mainprog)                            
H**************** PROTOTYPES ***************               
Dmainprog         pr                  extpgm('TRNUPR01')   
D                                2p 0                      
DisEven           pr              n                        
D                                2s 0                      
DisPrime          pr              n                        
D                                2s 0                      
Dfactorial        pr             7s 0                      
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
  wwNum =  1; //Uses numbers between 0 and 99              
  if isEven(wwNum);                                        
    dsply (%char(wwNum) + ' is even');                     
  else;                                                    
    dsply (%char(wwNum) + ' is odd');                      
  endif;                                                   
  ///                                                      
  if isPrime(wwNum);                                       
    dsply (%char(wwNum) + ' is a prime number');           
  else;                                                    
    dsply (%char(wwNum) + ' is not a prime number');       
  endif;                                                   
  ///                                                      
  //callp factorial(wwNum);                                
  dsply (%char(wwNum) + '! is ' + %char(factorial(wwNum)));
Pmainprog         e                                        
P**************** MAIN PROGRAM END ***************         
P**************** FUNCTIONS ***************                
PisEven           b                                        
  // Parameter                                             
D                 pi              n                        
DpiNum                           2s 0                      
D***                                                       
   if %rem(piNum:2) = 0;                                   
     return *on;                                           
   else;                                                   
     return *off;                                          
   endif;                                                  
PisEven           e                                        
P*****************                                         
PisPrime          b                                        
  // Parameter                                             
D                 pi              n                        
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
     return *on;                                           
   else;                                                   
     return *off;                                          
   endif;                                                  
PisPrime          e                                        
P*****************                                         
Pfactorial        b                                        
  // Parameter                                             
D                 pi             7s 0                      
DpiNum                           2s 0                      
  // Internal variables                                    
DzzCont           s              2s 0                      
DzzResult         s             15s 0                      
   if piNum >= 0 and piNum < 11;                           
       zzCont = 1 ;                                        
       zzResult = 1;                                       
     for zzCont to piNum;                                  
       zzResult = zzResult * zzCont;                       
     endfor;                                               
     return zzResult;                                      
     //dsply (%char(piNum) + '! is ' + %char(zzResult));   
   else;                                                   
     dsply 'Number to big or negative';                    
   endif;                                                  
Pfactorial        e        
C*2020/11/11                                
