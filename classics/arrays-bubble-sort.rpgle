H************** CONTROL STATEMENTS **************         
H option(*nodebugio) dftactgrp(*no)                       
D************** INTERNAL VARIABLES                        
Dlen              c                   const(05)           
Dwwarr            s              3s 0 dim(len)            
Di                s              4s 0                     
Dj                s              4s 0                     
Dk                s              4s 0                     
dwwrannum         s              4s 0                     
Dwwaux            s              4s 0                     
C************** MAIN PROGRAM **************               
  for i = 1 to len;                                       
    exec sql select int(floor(99 * rand())) into :wwrannum
             from sysibm/sysdummy1;                       
    wwarr(i) = wwrannum;                                  
  endfor;                                                 
  dsply 'First 5 non sorted elements are:';
  for i = 1 to 5;                          
    dsply %char(wwarr(i));                 
  endfor;                                  
  for i = 2 to len;                        
    for j = 1 to (len - 1);                
      k = j + 1;                           
      if wwarr(j) > wwarr(k);              
        wwaux = wwarr(j);                  
        wwarr(j) = wwarr(k);           
        wwarr(k) = wwaux;              
      endif;                           
    endfor;                            
  endfor;                              
  dsply 'First 5 sorted elements are:';
  for i = 1 to 5;                      
    dsply %char(wwarr(i));             
  endfor;                              
  *inlr = *on;
C*2020/11/17  