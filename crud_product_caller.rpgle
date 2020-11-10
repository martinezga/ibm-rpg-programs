H option(*nodebugio)                                    
Dprcrud           pr                  extpgm('TRPRCRGV')
D                                1a                     
D                                4s 0                   
D                               30a                     
D                               12s 2                   
D* Internal variables                                   
Dpaop             s              1a   inz('R')          
Dpaid             s              4s 0 inz(3)            
Dpaname           s             30a   inz('papa')       
Dpaprice          s             12s 2 inz(100)          
Dmsg              s             52a                     
  // Main program                                       
  prcrud(paop:paid:paname:paprice);                     
  *inlr = *on;                                          
C*2020/11/09