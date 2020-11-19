     H dftactgrp(*no)                                               
     D find_it         pr              n                            
     D                               20a                            
     D*** Internal variables                                        
     D len             c                   const(5)                 
     D wwarr           s             20a   dim(len) ctdata perrcd(1)
     D wwday           s             20a                            
     C***                                                           
       //wwday = 'Monday';                                          
       wwday = 'Saturday';                                          
       if find_it(wwday);                                           
         dsply 'Found';                                             
       else;                                                        
         dsply 'Did not find it';                                   
       endif;                                                       
       *inlr = *on;                                                 
     Pfind_it          b                  
     D                 pi              n  
     D yyword                        20a  
     D i               s              4s 0
     D flag            s               n  
       flag = *off;                       
       for i = 1 to len;                  
         if yyword = wwarr(i);            
           flag = *on;                    
           leave;       
         endif;         
       endfor;          
       if flag;         
         return *on;    
       else;            
         return *off;   
       endif;           
     Pfind_it          e
     C*2020/11/19 compile time arrays
**CTDATA WWARR   
Monday           
Tuesday          
Wednesday        
Thursday         
Friday           