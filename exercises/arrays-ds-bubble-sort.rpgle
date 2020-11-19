H************** CONTROL STATEMENTS **************                
H option(*nodebugio) dftactgrp(*no)                              
  exec sql set option closqlcsr=*endmod;                         
H**************** PROTOTYPES ***************                     
Dfillarray        pr                                             
D                                4s 0 value                      
Dshowarr          pr                                             
D                                4s 0 value                      
Dsortbypric       pr                                             
D************** INTERNAL VARIABLES                               
Dlen              c                   const(100)                 
Dwwarrpr        e ds                  extname('TRPROD') qualified
D                                     dim(len)                   
C************** MAIN PROGRAM **************                      
  dsply '----------';                                            
  fillarray(len);                                                
  dsply 'Unsorted products and prices';  
  showarr(5);                            
  sortbypric();                          
  dsply 'Sorted products by price';      
  showarr(5);                            
  *inlr = *on;                           
P************** PROCEDURES **************
*** Fill a ds array                      
Pfillarray        b                      
D                 pi                                       
Dlen                             4s 0 value                
  exec sql declare csrprod cursor for select * from TRPROD;
  exec sql open csrprod;                                   
  exec sql fetch csrprod for :len rows into :wwarrpr;      
Pfillarray        e                                        
*** Shows n elements array                                 
Pshowarr          b                                        
D                 pi                                       
Dn                               4s 0 value                      
Di                s              4s 0                            
Dyymsg            s             52a                              
  for i = 1 to n;                                                
    yymsg = %char(i) + ': ' + %trim(wwarrpr(i).prname) + '. $ ' +
            %char(wwarrpr(i).prpric);                            
    dsply yymsg;                                                 
  endfor;                                                        
Pshowarr          e                                              
Psortbypric       b                                 
Dyyrows           s              4s 0               
Di                s              4s 0               
Dj                s              4s 0               
Dk                s              4s 0               
Dyyauxpr          s             12s 2               
Dyyauxna          s             30a                 
  exec sql select count(*) into :yyrows from TRPROD;
  for i = 2 to yyrows;                              
    for j = 1 to (yyrows - 1);                 
      k = j + 1;                               
      if wwarrpr(j).prpric > wwarrpr(k).prpric;
  // switch price                              
        yyauxpr = wwarrpr(j).prpric;           
        wwarrpr(j).prpric = wwarrpr(k).prpric; 
        wwarrpr(k).prpric = yyauxpr;           
  // switch name                               
        yyauxna = wwarrpr(j).prname;           
        wwarrpr(j).prname = wwarrpr(k).prname;
        wwarrpr(k).prname = yyauxna;          
      endif;                                  
    endfor;                                   
  endfor;                                     
Psortbypric       e                           
C*2020/11/17                                  