D***PROTOTYPES                                          
Dtrprcr01         pr                  extpgm('TRPRCR01')
D                                1a                     
D                                4s 0                   
D                               30a                     
D                               12s 2                   
D                 pi                                    
Dpaop             s              1a                     
Dpaid             s              4s 0                   
Dpaname           s             30a                     
Dpaprice          s             12s 2                   
  paop = 'd';                                           
  paid = 49;                                            
  paname = 'pera';                                      
  paprice = 9999,99;                                    
  trprcr01(paop:paid:paname:paprice);                                    
  *inlr = *on;                                          
C*2020/11/14
