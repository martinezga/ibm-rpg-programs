H option(*nodebugio) dftactgrp(*no)                                    
Dfillarray        pr                                                   
D                                4s 0 value                            
Dlen              c                   const(100)                       
Darrnames         s             30a   dim(len)                         
Di                s              4s 0                                  
Dwwname           s             30a                                    
D***                                                                   
*************** MAIN PROGRAM **************                            
  fillarray(len);                                                      
  // ***************************** Search a name and shows its position
  wwname = 'Name11';            //*                                    
  i = %lookup(wwname:arrnames);                                        
  dsply (%trim(wwname) + ' is in ' + %char(i) + ' position');          
  *inlr = *on;                                                         
 ***************** PROCEDURES *************** 
Pfillarray        b                          
D                 pi                         
Dlen                             4s 0 value  
Di                s              4s 0        
  for i = 1 to len;                          
    arrnames(i) = ('Name' + %char(i));       
  endfor;                                    
Pfillarray        e                          
C*2020/11/18                                 