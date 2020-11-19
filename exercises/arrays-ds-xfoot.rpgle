H option(*nodebugio) dftactgrp(*no)                                
Dfillarray        pr                                               
D                                4s 0 value                        
Dlen              c                   const(100)                   
Darr_pur        e ds                  extname('TRPURC') qualified  
D                                     dim(len) inz(*extdft)        
Dpu_qty           s                   like(arr_pur.puquan) dim(len)
Di                s              4s 0                              
Dpu_sum           s              6s 0                              
*** Main prog                                                      
  fillarray(len);                                                  
  for i = 1 to len;                                                
    pu_qty(i) = arr_pur(i).puquan;                                 
  endfor;                                                          
  pu_sum = %xfoot(pu_qty);                                         
    dsply pu_sum;                                                  
  *inlr = *on;                                            
Pfillarray        b                                       
D                 pi                                      
Dlen                             4s 0 value               
Di                s              4s 0                     
  exec sql set option closqlcsr=*endmod;                  
  exec sql declare csrpurc cursor for select * from TRPURC;
  exec sql open csrpurc;                                  
  exec sql fetch csrpurc for :len rows into :arr_pur;     
Pfillarray        e
C*2020/11/18       