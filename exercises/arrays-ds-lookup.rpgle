H************** CONTROL STATEMENTS **************                
H option(*nodebugio) dftactgrp(*no)                              
***************** PROTOTYPES ***************                     
Dfillarray        pr                                             
D                                4s 0 value                      
D************** INTERNAL VARIABLES                               
Dlen              c                   const(100)                 
Darrprod        e ds                  extname('TRPROD') qualified
D                                     dim(len)                   
Did               s              4s 0                            
dwwrows           s              4s 0                            
Dwwprod           s             30a                              
Dwwmsg            s             52a                              
C************** MAIN PROGRAM **************                      
  fillarray(len);                                          
  wwprod = 'papa';                                         
  id = %lookup(wwprod:arrprod(*).prname);                  
  dsply id;                                                
  *inlr = *on;                                             
***************** PROCEDURES ***************               
Pfillarray        b                                        
D                 pi                                       
Dlen                             4s 0 value                
  exec sql set option closqlcsr=*endmod;                   
  exec sql declare csrprod cursor for select * from TRPROD;
  exec sql open csrprod;                             
  exec sql fetch csrprod for :len rows into :arrprod;
Pfillarray        e                                  
C*2020/11/18                                         