H option(*nodebugio) datfmt(*iso)                                      
F*----------File definition------------                                
FTRPURC    UF A E           K DISK                                     
FTRPROD    UF A E           K DISK                                     
FTRCLIE    UF A E           K DISK                                     
D*----------Variable definition----------                              
Dclie             s             30a                                    
Dprod             s             30a                                    
DshowPurc         s             50a                                    
DtStamp           s               z                                    
DsysTStamp        s               z   inz(*sys)                        
DsysDS           sds                                                   
DsysUser                254    263                                     
C*----------Parameter list--------------                               
C*----------PURC CALLER:--------------                                 
C     *ENTRY        PLIST                                              
C                   PARM                    PAOP              1  
C                   PARM                    PAID              3 0
C                   PARM                    PACLIE            8 0
C                   PARM                    PAPROD            4 0
C                   PARM                    PAQUAN            2 0
C*-------TRPURC -> Compound key:                                 
C     PURCK         KLIST                                        
C                   KFLD                    PAID                 
C                   KFLD                    PACLIE               
C                   KFLD                    PAPROD                     
C     PURKSE        KLIST                                              
C                   KFLD                    PAID                       
C                   KFLD                    PACLIE                     
C*---------Option selection-------------                               
C                   SELECT                                             
C     PAOP          WHENEQ    'C'                                      
C                   EXSR      CRTESR                                   
C     PAOP          WHENEQ    'R'                                      
C                   EXSR      READSR                                   
C     PAOP          WHENEQ    'U'                                      
C                   EXSR      UPDTSR                                   
C     PAOP          WHENEQ    'D'                                      
C                   EXSR      DLTESR                                   
C     PAOP          WHENEQ    'S'                                      
C                   EXSR      SRCHSR                                   
C                   OTHER                                              
C     'InvalidOptio'DSPLY                                              
C                   ENDSL                                              
C                   SETON                                            LR
C*----------Creation subrutine-----------                              
C     CRTESR        BEGSR                                              
C     *end          setll     trpurc                                   
C                   readp     retrpurc                                 
C                   exsr      blnksr                                   
C                   eval      puID += 1                                
C                   eval      puClie = paclie                          
C                   eval      puProd = paProd                          
C                   eval      puQuan = paQuan                          
C                   eval      PUCRTS = sysTStamp                       
C                   eval      PUCRUS = sysUser                         
C                   write     retrpurc                                 
C                   ENDSR                                              
C*------------Read subrutine-------------                              
C     READSR        BEGSR                                              
C     purck         chain     trpurc                                   
C                   if        %found() and pudeus = ''                 
C                   eval      showPurc = 'puID: ' + %char(puid) +      
C                                       ' clie: ' + %char(puclie) +    
C                                       ' prodID: ' + %char(puprod) +  
C                                       ' puquan: ' + %char(puquan)    
C     showPurc      dsply                                              
C                   else                                               
C     'error'       dsply                                              
C                   endif                                              
C                   ENDSR                                              
C*...............UPDATE SUBRUTINE..................                    
C     UPDTSR        BEGSR                                              
C     purck         chain     retrpurc                                 
C                   if        %found() and pudeus = ''                 
C                   eval      puquan = paquan                          
C                   eval      puUpts = sysTStamp                       
C                   eval      puUpus = sysUser                         
C                   update    retrpurc                                 
C                   else                                               
C     'error'       dsply                                              
C                   endif                                              
C                   ENDSR                                              
C*...............DELETE SUBRUTINE.............                         
C     DLTESR        BEGSR                                              
C     paid          chain     retrpurc                                 
C                   if        %found() and pudeus = ''                 
C                   eval      pudets = sysTStamp                       
C                   eval      pudeus = sysUser                         
C                   update    retrpurc                                 
C                   else                                               
C     'already del' dsply                                              
C                   endif                                              
C                   ENDSR                                              
c*..........Search purchase by ID and DNI subrutine...........         
c     srchsr        begsr                                              
c     'searching'   dsply                                              
c     purkse        setll     trpurc                                   
c     purkse        reade     trpurc                                   
c                   IF        %equal(trpurc)                           
c                   eval      clie = 'ID: ' + %char(puid) + ' DNI: ' + 
c                                    %char(puclie)                     
c     clie          dsply                                              
c                   dow       not %eof(trpurc)                         
C     puprod        chain     trprod                                   
c                   eval      prod = 'Prod: ' + %trim(prname) +        
c                                    ' Quant: ' + %char(puquan)        
c     prod          dsply                                              
c     purkse        reade     trpurc                                   
c                   enddo                                              
c                   else                                               
c     'not found'   dsply                                              
c                   ENDIF                                              
c                   endsr                                              
C*.........Initial subrutines..........                                
C     *inzsr        begsr                                              
C***Parameters validation                                              
C                   if        paClie < 0 or paProd < 0 or paQuan < 0   
C                   eval      *inlr = *on                              
C     'Invalid parm'dsply                                              
C                   endif                                              
C***Client validation                                                  
C     paclie        chain     trclie                                   
C                   if        not %found()                             
C                   eval      *inlr = *on                              
C     'Cli not foun'dsply                                              
C     'Creat TRCLIE'dsply                                              
C                   endif                                              
C***ID product validation                                              
C     paprod        chain     trprod                                   
C                   if        not %found() or not(prdeus = '')         
C                   eval      *inlr = *on                              
C     'prID not val'dsply                                              
C                   endif                                              
C*......End initial subrutine....                                      
C                   endsr                                              
C*------Blank variables subrutine-------                               
C     blnksr        begsr                                              
C                   eval      puClie = 0                               
C                   eval      puProd = 0                               
C                   eval      puQuan = 0                               
C                   eval      puCrts = tStamp                          
C                   eval      puCrus = ''                              
C                   eval      puUpts = tStamp                          
C                   eval      puUpus = ''                              
C                   eval      puDets = tStamp                          
C                   eval      puDeus = ''                              
C                   endsr                                              
C*2020/11/03