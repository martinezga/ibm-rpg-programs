H option(*nodebugio)                                                     
D* __Variable definition__                                               
DpaOp             s              1a                                      
DpaDni            s              8p 0                                    
DpaName           s             30a                                      
DtStamp           c                   const(z'0001-01-01-00.00.00.00000')
DvalDni           s               n                                      
DvalName          s               n                                      
DclieTable      e ds                  extname(trclie)                    
Dwwcont           s              1s 0                                    
DisDel            s             10a                                      
DsysDS           sds                                                     
DsysUser                254    263                                       
Dmsg                            52a                                      
C* __Program parameters__ -> Use TRCLCRCA program                        
C     *entry        plist                                                
C                   parm                    paOp                         
C                   parm                    paDni                        
C                   parm                    paName                       
C/EXEC SQL                                                               
C+ Set Option Commit=*NONE                                               
C/END-EXEC                                                               
C* __Program selection__                                                 
C     '------------'dsply                                                
C                   exsr      srValInput                                 
C                   if        valDni = *on and valName = *on             
C                   select                                               
C                   when      paOp = 'C' or paOp = 'c'                   
C                   exsr      srCreate                                   
C                   when      paOp = 'R' or paOp = 'r'                   
C                   exsr      srRead                                     
C                   when      paOp = 'U' or paOp = 'u'                   
C                   exsr      srUpdate                                   
C                   when      paOp = 'D' or paOp = 'd'                   
C                   exsr      srDelete                                   
C                   other                                                
C                   eval      msg = 'Invalid Operation'                  
C     msg           dsply                                                
C                   endsl                                                
C                   endif                                                
C                   eval      *inlr = *on                                
C* __Subrutines definition__                                             
C     srCreate      begsr                                                
C                   exsr      srCounDni                                  
C                   if        wwcont > 0                                 
C                   eval      msg = 'DNI already exist'                  
C     msg           dsply                                                
C                   else                                                 
C                   exsr      srblanks                                   
C                   exsr      srAsign                                    
C                   exsr      srCrAudit                                  
C                   exsr      srInsert                                   
C                   endif                                                
C                   endsr                                                
C*                                                                       
C     srRead        begsr                                                
C                   exsr      srIsDeleted                                
C                   exsr      srCounDni                                  
C                   if        wwcont = 0 or not(isDel = '')              
C                   eval      msg = 'DNI do not exist or deleted'        
C     msg           dsply                                                
C                   else                                                 
C                   exsr      srReadDni                                  
C                   eval      msg = 'Client DNI: ' + %char(clDni) +      
C                                   ' Name: '+ clName                    
C     msg           dsply                                                
C                   endif                                                
C                   endsr                                                
C*                                                                       
C     srUpdate      begsr                                                
C                   exsr      srIsDeleted                                
C                   exsr      srCounDni                                  
C                   if        wwcont = 0 or not(isDel = '')              
C                   eval      msg = 'DNI do not exist or deleted'        
C     msg           dsply                                                
C                   else                                                 
C                   exsr      srAsign                                    
C                   exsr      srUpAudit                                  
C                   exsr      srTUpdat                                   
C                   endif                                                
C                   endsr                                                
C*                                                                       
C     srDelete      begsr                                                
C                   exsr      srIsDeleted                                
C                   exsr      srCounDni                                  
C                   if        wwcont = 0 or not(isDel = '')              
C                   eval      msg = 'DNI do not exist or deleted'        
C     msg           dsply                                                
C                   else                                                 
C                   exsr      srAsign                                    
C                   exsr      srDeAudit                                  
C                   exsr      srLogicDrop                                
C                   endif                                                
C                   endsr                                                
C*                                                                       
C     srValInput    begsr                                                
C                   eval      valDni = *on                               
C                   eval      valName = *on                              
C                   if        padni > 9999999 and padni > 99999999       
C                   eval      valDni = *off                              
C                   eval      msg = 'DNI not valid'                      
C     msg           dsply                                                
C                   endif                                                
C                   if        paName = ''                                
C                   eval      valName = *off                             
C                   eval      msg = 'Name client is required'            
C     msg           dsply                                                
C                   endif                                                
C                   endsr                                                
C*                                                                       
C     srblanks      begsr                                                
C                   eval      clDni = 0                                  
C                   eval      clName = ''                                
C                   eval      clCrts = tStamp                            
C                   eval      clCrus = ''                                
C                   eval      clUpts = tStamp                            
C                   eval      clUpus = ''                                
C                   eval      clDets = tStamp                            
C                   eval      clDeus = ''                                
C                   endsr                                                
C*                                                                       
C     srAsign       begsr                                                
C                   eval      clDni = paDni                              
C                   eval      clName = paName                            
C                   endsr                                                
C*                                                                       
C     srCrAudit     begsr                                                
C                   eval      clcrts = %timestamp()                      
C                   eval      clcrus = sysUser                           
C                   endsr                                                
C*                                                                       
C     srInsert      begsr                                                
C/EXEC SQL                                                               
C+ insert into trclie values(:clieTable)                                 
C/END-EXEC                                                               
C                   exsr      srsqlcod                                   
C                   endsr                                                
C*                                                                       
C     srCounDni     begsr                                                
C/EXEC SQL                                                               
C+ select count(*) into :wwcont from trclie where clDni = :paDni         
C/END-EXEC                                                               
C                   endsr                                                
C*                                                                       
C     srsqlcod      begsr                                                
C                   if        sqlcod = 0                                 
C     'success'     dsply                                                
C                   elseif    sqlcod > 0                                 
C     'warning'     dsply                                                
C                   elseif    sqlcod < 0                                 
C     sqlcod        dsply                                                
C     'error'       dsply                                                
C                   endif                                                
C                   endsr                                                
C     srReadDni     begsr                                                
C/EXEC SQL                                                               
C+ select * into :clieTable from trclie where clDni = :paDni             
C/END-EXEC                                                               
C                   endsr                                                
C*                                                                       
C     srUpAudit     begsr                                                
C                   eval      clupts = %timestamp()                      
C                   eval      clupus = sysUser                           
C                   endsr                                                
C*                                                                       
C     srTUpdat      begsr                                                
C/EXEC SQL                                                               
C+ update trclie set clName = :clName, clupts = :clupts,                 
C+                   clupus = :clupus where cldni = :cldni               
C/END-EXEC                                                               
C                   exsr      srsqlcod                                   
C                   endsr                                                
C*                                                                       
C     srDeAudit     begsr                                                
C                   eval      cldets = %timestamp()                      
C                   eval      cldeus = sysUser                           
C                   endsr                                                
C*                                                                       
C     srLogicDrop   begsr                                                
C/EXEC SQL                                                               
C+ update trclie set cldets = :cldets, cldeus = :cldeus                  
C+               where cldni = :cldni                                    
C/END-EXEC                                                               
C                   exsr      srsqlcod                                   
C                   endsr                                                
C*                                                                       
C     srIsDeleted   begsr                                                
C/EXEC SQL                                                               
C+ select cldeus into :isDel from trclie where clDni = :paDni            
C/END-EXEC                                                               
C                   endsr                                                
C*                                                                       
C*2020/11/05