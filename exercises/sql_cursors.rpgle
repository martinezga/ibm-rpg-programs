H option(*nodebugio)                                         
Dmsg              s             52a                          
DclieTable      e ds                  extname(trclie)        
  dsply '-------';                                           
  // Cursor init                                             
  exec sql declare c1 cursor for                             
           select *                                          
           from trclie;                                      
  exec sql open c1;   // Open cursor                         
  if sqlcod = 0;   // Show content                           
    exsr srCurFetch;                                         
    dow sqlcod = 0;                                          
      eval msg = 'DNI: ' + %char(clDni) + ' Name: ' + clName;
      dsply msg;                                             
      exsr srCurFetch;                                       
    enddo;                                                   
    exec sql close c1;  // Close cursor                      
  endif;                                                     
  *inlr = *on;                                               
                                                             
  // *** Program subroutines ***                             
  begsr srCurFetch;   // Fetch cursor                        
    exec sql fetch c1 into :clieTable;                       
  endsr;    
  C*2020/11/06                                                 