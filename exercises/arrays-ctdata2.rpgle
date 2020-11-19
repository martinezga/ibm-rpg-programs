    H dftactgrp(*no)                                               
    D find_it         pr             4s 0                          
    D                               20a                            
    D*** Internal variables                                        
    D len             c                   const(5)                 
    D wwarr1          s              4s 0 dim(len) ctdata perrcd(1)
    D wwarr2          s             20a   dim(len) alt(wwarr1)     
    D wwnum           s              4s 0                          
    D wwday           s             20a                            
    D wwfindit        s              4s 0                          
    C***                                                           
      wwday = 'Monday';                                            
      //wwday = 'Saturday';                                        
      wwfindit = find_it(wwday);                                   
      if wwfindit > 0;                                             
        dsply wwarr1(wwfindit);                                    
      else;                              
        dsply 'Did not find it';         
      endif;                             
      *inlr = *on;                       
    Pfind_it          b                  
    D                 pi             4s 0
    D yyword                        20a  
    D i               s              4s 0
    D flag            s               n  
    D yynum           s       
      flag = *off;            
      for i = 1 to len;       
        if yyword = wwarr2(i);
          flag = *on;         
          leave;              
        endif;                
      endfor;                 
      if flag;                
        return i;      
      else;            
        return 0;      
      endif;           
    Pfind_it          e
    C*2020/11/19 compile time arrays
**CTDATA WWARR1         
0001Monday              
0002Tuesday             
0003Wednesday           
0004Thursday 
0005Friday   