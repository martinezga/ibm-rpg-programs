H option(*nodebugio)                                                   
Dlen              s              2s 0                                  
Darrnames         s             30a   dim(15)                          
Di                s              2s 0                                  
Dwwname           s             30a                                    
D***                                                                   
  len = 15;                                                            
  for i = 1 to len;                                                    
    arrnames(i) = ('Name' + %char(i));                                 
  endfor;                                                              
  // ***************************** Search a name and shows its position
  // *****************************                                     
  wwname = 'Name11';            //*                                    
  // *****************************                                     
  for i = 1 to len;                                                    
    if wwname = arrnames(i);                                           
      dsply (%trim(arrnames(i)) + ' is at position ' + %char(i));
      leave;                                                     
    endif;                                                       
  endfor;                                                        
  *inlr = *on;                                                   
C*2020/11/16