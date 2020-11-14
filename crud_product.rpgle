H************** CONTROL STATEMENTS **************                      
H option(*nodebugio) dftactgrp(*no)                                    
D************** DEFINITION STATEMENTS **************                   
D***Prototypes                                                         
Dmainp            pr                  extpgm('TRPRCR01')               
D                                1a                                    
D                                4s 0                                  
D                               30a                                    
D                               12s 2                                  
Dcreateprod       pr                                                   
D                                1a                                    
D                               30a                                    
D                               12s 2                                  
Dreadprod         pr                                                   
D                                4s 0                                  
Dupdateprod       pr                                                   
D                                1a                                    
D                                4s 0                                  
D                               30a   options(*omit)                   
D                               12s 2 options(*omit)                   
Ddeleteprod       pr                                                   
D                                1a                                    
D                                4s 0                                  
D***Functions prototypes                                               
Dblanksvar        pr              n                                    
Dasignvar         pr              n                                    
D                                1a                                    
D                               30a                                    
D                               12s 2                                  
Dauditvar         pr              n                                    
D                                1a                                    
Dasignid          pr              n                                    
Dinsertprod       pr             5s 0                                  
Dvalidid          pr              n                                    
D                                4s 0                                  
Dnotdeleted       pr              n                                    
D                                4s 0                                  
Dsearchbyid       pr            50a                                    
D                                4s 0                                  
Dupdatepr         pr             5s 0                                  
D                                4s 0                                  
D                               30a                                    
D                               12s 2                                  
Dlogicdel         pr              n                                    
D                                1a                                    
D                                4s 0                                  
D                              150a   options(*omit)                   
D***                                                                   
P************** MAIN PROGRAM **************                            
D*** Main Parameters                                                   
D                 pi                                                   
Dpa_op                           1a                                    
Dpapr_id                         4s 0                                  
Dpapr_name                      30a                                    
Dpapr_price                     12s 2                                  
D*** Internal variables                                                
Dproddata       e ds                  extname(trprod)                  
Dtstamp           s               z   inz(z'0001-01-01-00.00.00.00000')
Dsysds           sds                                                   
Dsysuser                254    263                                     
C*                                                                     
  exec sql set Option Commit=*NONE;                                    
  dsply '--------';                                                    
  select;                                                              
    when pa_op = 'C' or pa_op = 'c';                                   
      createprod(pa_op:papr_name:papr_price);                          
    when pa_op = 'R' or pa_op = 'r';                                   
      readprod(papr_id);                                               
    when pa_op = 'U' or pa_op = 'u';                                   
      updateprod(pa_op:papr_id:papr_name:papr_price);                  
    when pa_op = 'D' or pa_op = 'd';                                   
      deleteprod(pa_op:papr_id);                                       
    other;                                                             
      dsply 'Wrong selection';                                         
  endsl;                                                               
  *inlr = *on;                                                         
P************** PROCEDURES **************                              
P*** CREATE PRODUCT                                                    
Pcreateprod       b                                                    
D*** Parameters                                                        
D                 pi                                                   
Dpa_op                           1a                                    
Dpr_name                        30a                                    
Dpr_price                       12s 2                                  
C***                                                                   
  blanksvar();                                                         
  asignvar(pa_op:pr_name:pr_price);                                    
  auditvar(pa_op);                                                     
  asignid();                                                           
  insertprod();   // This function returns the sqlcod                  
  if sqlcod = 0;                                                       
    dsply 'product created';                                           
  elseif sqlcod > 0;                                                   
    dsply 'creation warning';                                          
  elseif sqlcod < 0;                                                   
    dsply 'creation error';                                            
  endif;                                                               
Pcreateprod       e                                                    
P*** READ PRODUCT                                                      
Preadprod         b                                                    
D                 pi                                                   
Dpr_id                           4s 0                                  
C***                                                                   
  // Search by ID                                                      
  if notdeleted(pr_id) and validid(pr_id);                             
    dsply searchbyid(pr_id);                                           
  else;                                                                
    dsply 'read error';                                                
  endif;                                                               
  // Search by name product  +++complicado cuando hay mas de 1 row =   
  // Search by price +++no+++                                          
Preadprod         e                                                    
P*** UPDATE PRODUCT                                                    
Pupdateprod       b                                                    
D                 pi                                                   
Dpaop                            1a                                    
Dpaprid                          4s 0                                  
Dpaprname                       30a   options(*omit)                   
Dpaprprice                      12s 2 options(*omit)                   
  if notdeleted(paprid) and validid(paprid);                           
    auditvar(paop);                                                    
    if updatepr(paprid:paprname:paprprice) = 0;                        
    //updatepr(paprid:*omit:paprprice);                                
    //updatepr(paprid:paprname:*omit);                                 
      dsply 'updated';                                                 
    else;                                                              
      dsply 'update error';                                            
    endif;                                                             
  else;                                                                
    dsply 'error';                                                     
  endif;                                                               
Pupdateprod       e                                                    
P*** DELETE PRODUCT                                                    
Pdeleteprod       b                                                    
D                 pi                                                   
Dpaop                            1a                                    
Dpaprid                          4s 0                                  
Dsqlupdate        s             50a                                    
Dsqlset           s             50a                                    
Dsqlwhere         s             50a                                    
Dsqlline          s            150a                                    
  dsply 'deleting';                                                    
  if notdeleted(paprid) and validid(paprid);                           
    auditvar(paop);                                                    
    sqlupdate = 'update trprod';                                       
    sqlset = 'set prdeus = :prdeus, prdets = :prdets';                 
    sqlwhere = 'where prid = :paid';                                   
    sqlline = %trim(sqlupdate)+' '+%trim(sqlset)+' ' + %trim(sqlwhere);
    logicdel(paop:paprid:*omit);                                       
  else;                                                                
    dsply 'delete error';                                              
  endif;                                                               
Pdeleteprod       e                                                    
P************** FUNCTIONS **************                               
P*** Blanks variables                                                  
Pblanksvar        b                                                    
D                 pi              n                                    
C***                                                                   
  prid = 0;                                                            
  prname = '';                                                         
  prpric = 0;                                                          
  prcrts = tstamp;                                                     
  prcrus = '';                                                         
  prupts = tstamp;                                                     
  prupus = '';                                                         
  prdets = tstamp;                                                     
  prdeus = '';                                                         
  return *on;                                                          
Pblanksvar        e                                                    
P*** Products variables asignament                                     
Pasignvar         b                                                    
D                 pi              n                                    
Dpaop                            1a                                    
Dpaname                         30a                                    
Dpaprice                        12s 2                                  
C***                                                                   
  if paop = 'c' or paop = 'C';                                         
    prname = paname;                                                   
    prpric = paprice;                                                  
    return *on;                                                        
  else;                                                                
    dsply 'Asigment error';                                            
    return *off;                                                       
  endif;                                                               
Pasignvar         e                                                    
P*** Audit variables asignament                                        
Pauditvar         b                                                    
D                 pi              n                                    
Dpaop                            1a                                    
C***                                                                   
  if paop = 'c' or paop = 'C';                                         
    prcrus = sysUser;                                                  
    prcrts = %timestamp();                                             
    return *on;                                                        
  elseif paop = 'u' or paop = 'U';                                     
    prupus = sysUser;                                                  
    prupts = %timestamp();                                             
    return *on;                                                        
  elseif paop = 'd' or paop = 'D';                                     
    prdeus = sysUser;                                                  
    prdets = %timestamp();                                             
    return *on;                                                        
  else;                                                                
    dsply 'Audit var error';                                           
    return *off;                                                       
  endif;                                                               
Pauditvar         e                                                    
P*** ID asignament                                                     
Pasignid          b                                                    
D                 pi              n                                    
Dmaxid            s              4s 0                                  
  exec sql select max(prid) into :maxid from trprod;                   
  if maxid >= 0;                                                       
    prid = maxid + 1;                                                  
    return *on;                                                        
  else;                                                                
    return *off;                                                       
  endif;                                                               
Pasignid          e                                                    
P*** SQL product creation                                              
Pinsertprod       b                                                    
D                 pi             5s 0                                  
  dsply 'creating';                                                    
  exec sql insert into trprod values(:proddata);                       
  return sqlcod;                                                       
Pinsertprod       e                                                    
P*** ID validation                                                     
Pvalidid          b                                                    
D                 pi              n                                    
Dpaid                            4s 0                                  
  if paid >= 0;                                                        
    exec sql select prid into :proddata.prid                           
             from trprod where prid = :paid;                           
    if sqlcode = 0;                                                    
      return *on;                                                      
    else;                                                              
      dsply 'enter valid id';                                          
      return *off;                                                     
    endif;                                                             
  else;                                                                
    dsply 'enter valid id';                                            
    return *off;                                                       
  endif;                                                               
Pvalidid          e                                                    
P*** Verify if product is not deleted                                  
Pnotdeleted       b                                                    
D                 pi              n                                    
Dpaid                            4s 0                                  
  exec sql select prdeus into :proddata.prdeus                         
           from trprod                                                 
           where prid = :paid;                                         
  if prdeus = '';                                                      
    return *on;                                                        
  else;                                                                
    dsply 'Product deleted';                                           
    return *off;                                                       
  endif;                                                               
Pnotdeleted       e                                                    
P*** Search product by ID                                              
Psearchbyid       b                                                    
D                 pi            50a                                    
Dpaid                            4s 0                                  
  exec sql select prname, prpric                                       
           into :proddata.prname, :proddata.prpric                     
           from trprod                                                 
           where prid = :paid;                                         
  if sqlcode = 0;                                                      
    return ('Name: ' + prname + ' | Price: ' + %char(prpric));         
  else;                                                                
    return 'error';                                                    
  endif;                                                               
Psearchbyid       e                                                    
P*** Update product IN SQL                                             
Pupdatepr         b                                                    
D                 pi             5s 0                                  
Dpaid                            4s 0                                  
Dpaname                         30a                                    
Dpaprice                        12s 2                                  
    if (paname = '' or paname = '-1') and paprice = -1;                
      dsply 'Did not receive something to update';                     
      return 1;                                                        
    elseif paname = '' or paname = '-1';                               
      exec sql update trprod set prpric = :paprice, prupus = :prupus,  
                                 prupts = :prupts                      
                             where prid = :paid;                       
      return sqlcod;                                                   
    elseif paprice = -1;                                               
      exec sql update trprod set prname = :paname, prupus = :prupus,   
                                 prupts = :prupts                      
                             where prid = :paid;                       
      return sqlcod;                                                   
    else;                                                              
      exec sql update trprod set prname = :paname, prpric = :paprice,  
                                 prupus = :prupus, prupts = :prupts    
                             where prid = :paid;                       
      return sqlcod;                                                   
    endif;                                                             
Pupdatepr         e                                                    
Plogicdel         b                                                    
D                 pi              n                                    
Dpaop                            1a                                    
Dpaid                            4s 0                                  
Dsqlline                       150a   options(*omit)                   
  if paop = 'd' or paop = 'D';                                         
    //exec sql prepare s1 from :sqlline;                               
    //exec sql execute s1;                                             
    exec sql update trprod set prdeus = :prdeus, prdets = :prdets      
                           where prid = :paid;                         
    if sqlcode = 0;                                                    
      dsply 'deleted';                                                 
      return *on;                                                      
    else;                                                              
      dsply sqlcode;                                                   
      return *off;                                                     
    endif;                                                             
  else;                                                                
    dsply 'error';                                                     
    return *off;                                                       
  endif;                                                               
Plogicdel         e                                                    
P*                                                                     
C*2020/11/14
