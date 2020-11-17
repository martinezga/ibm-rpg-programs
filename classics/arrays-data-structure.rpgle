H************** CONTROL STATEMENTS **************                
H option(*nodebugio) dftactgrp(*no)                              
D************** INTERNAL VARIABLES                               
Dlen              c                   const(100)                 
Dlen2             s              4s 0 inz(len)                   
Darrclie        e ds                  extname('TRCLIE') qualified
D                                     dim(len)                   
Di                s              4s 0                            
dwwrows           s              4s 0                            
Dwwdni            s              8s 0                            
Dwwmsg            s             52a                              
C************** MAIN PROGRAM **************                      
  exec sql set option closqlcsr=*endmod;                         
  exec sql declare csrclie cursor for select * from TRCLIE;      
  exec sql open csrclie;                                         
  exec sql fetch csrclie for :len2 rows into :arrclie;           
    exec sql get diagnostics :wwrows = ROW_COUNT;             
    // ***************************** Search dni and shows name
    // *****************************                          
    wwdni = 95896678;            //*                          
    // *****************************                          
    for i = 1 to wwrows;                                      
    if wwdni = arrclie(i).cldni;                            
      wwmsg = (%char(wwdni) + ' corresponds to ' +          
            %trim(arrclie(i).clname));                     
      dsply wwmsg;
    endif;      
  endfor;       
  *inlr = *on;
C*2020/11/16