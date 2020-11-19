H option(*nodebugio) dftactgrp(*no)                                
  exec sql set option closqlcsr=*endmod;                           
Dfillarray        pr                                               
D                                4s 0 value                        
Dshowarr          pr                                               
D                               10a   value                        
D                                4s 0 value                        
Dlen              c                   const(100)                   
Darr_pur        e ds                  extname('TRPURC') qualified  
D                                     dim(len) inz                 
Dpu_qty           s                   like(arr_pur.puquan) dim(len)
Di                s              4s 0                              
Dpu_sum           s              6s 0                              
D wwrows          s              4s 0                              
*** Main prog                                                      
  fillarray(len);                                                  
  exec sql get diagnostics :wwrows = ROW_COUNT;
  for i = 1 to wwrows;                         
    pu_qty(i) = arr_pur(i).puquan;             
  endfor;                                      
  showarr('pu_qty':5);                         
  sorta %subarr(pu_qty:1:wwrows);              
  showarr('pu_qty':5);                         
  *inlr = *on;                                 
Pfillarray        b                            
D                 pi                                       
Dlen                             4s 0 value                
Di                s              4s 0                      
  exec sql declare csrpurc cursor for select * from TRPURC;
  exec sql open csrpurc;                                   
  exec sql fetch csrpurc for :len rows into :arr_pur;      
Pfillarray        e                                        
Pshowarr          b                                        
D                 pi                                       
Dyyselec                        10a   value      
Dyyn                             4s 0 value      
Di                s              4s 0            
Dyymsg            s             52a              
  if yyselec = 'pu_qty';                         
    for i = 1 to yyn;                            
      yymsg = %char(i) + ': ' + %char(pu_qty(i));
      dsply yymsg;                               
    endfor;                                      
  else;            
    dsply 'error'; 
  endif;           
Pshowarr          e
C*2020/11/18       