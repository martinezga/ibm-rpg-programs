H option(*nodebugio) datfmt(*iso)                                      
F* FILE DEFINITION                                                     
FTRPROD    UF A E           K DISK                                     
D* Variable definition                                                 
Dmax              s              4s 0 inz(0)                           
Dflag3            s              1s 0 inz(0)                           
Dflag4            s              1s 0 inz(0)                           
DprodDel          s               n                                    
DsysTstamp        s               z   inz(*sys)                        
DtStamp           s               z                                    
Dsysds           sds                                                   
DsysUser                254    263                                     
D*Parameter list                                                       
D                 pi                                                   
Dpaop                            1a                                    
Dpaid                            4s 0                                  
Dpaname                         30a                                    
Dpapric                         12s 2                                  
C*OPTION SELECTION                                                     
C                   SELECT                                             
C     PAOP          WHENEQ    'C'                                      
C                   EXSR      CRTESR                                   
C     PAOP          WHENEQ    'R'                                      
C                   EXSR      READSR                                   
C     PAOP          WHENEQ    'U'                                      
C                   EXSR      UPDTSR                                   
C     PAOP          WHENEQ    'D'                                      
C                   EXSR      DLTESR                                   
C                   OTHER                                              
C     'ERR400'      DSPLY                                              
C                   ENDSL                                              
C                   SETON                                            LR
C*-----------Auxiliar subrutines starts-----------                     
C* product is active?                                                  
C     isActive      begsr                                              
C     paid          chain     trprod                                   
C                   if        %found()                                 
C                   if        not(prdeus = '')                         
C                   eval      prodDel = *on                            
C                   endif                                              
C                   endif                                              
C                   endsr                                              
C*-----------Auxiliar subrutines ends-----------                       
C*CREATION SUBRUTINE                                                   
C*call prodcrud parm(c x'00000f' Papa x'0000000011100f')               
C     CRTESR        BEGSR                                              
C                   READ      RETRPROD                               90
C*                  READ      TRPROD                                 90
C                   dow       *in90 = *off                             
C     PRID          IFGT      max                                      
C                   eval      max = prid                               
C                   ENDIF                                              
C                   READ      RETRPROD                               90
C*                  READ      TRPROD                                 90
C                   ENDDO                                              
C                   eval      prid = max + 1                           
C                   MOVEL     PANAME        PRNAME                     
C                   eval      prpric = papric                          
C                   eval      prcrts = sysTstamp                       
C                   eval      prcrus = sysUser                         
C                   eval      prupts = tStamp                          
C                   eval      prupus = ''                              
C                   eval      prdets = tStamp                          
C                   eval      prdeus = ''                              
C                   WRITE     RETRPROD                                 
C                   ENDSR                                              
C*READ SUBRUTINE                                                       
C     READSR        BEGSR                                              
C                   exsr      isActive                                 
C                   if        prodDel = *off                           
C     paid          chain     trprod                                   
C                   IF        %found()                                 
C     prid          dsply                                              
C     prname        dsply                                              
C     prpric        dsply                                              
C                   else                                               
C     'ID error'    dsply                                              
C                   ENDIF                                              
C                   else                                               
C     'Deleted'     dsply                                              
C                   endif                                              
C                   ENDSR                                              
C*UPDATE SUBRUTINE                                                     
C     UPDTSR        BEGSR                                              
C                   READ      RETRPROD                               90
C                   exsr      isActive                                 
C                   if        prodDel = *off                           
C                   DOW       *in90 = *off                             
C     PRID          IFEQ      PAID                                     
C                   eval      flag3 += 1                               
C     PAPRIC        IFGE      0                                        
C                   eval      prpric = papric                          
C                   eval      flag4 += 1                               
C                   ENDIF                                              
C     PANAME        IFNE      '-1'                                     
C                   eval      flag4 += 1                               
C                   MOVEL     *BLANKS       PRNAME                     
C                   MOVEL     PANAME        PRNAME                     
C                   ENDIF                                              
C     flag4         IFGT      0                                        
C                   eval      prupts = sysTstamp                       
C                   eval      prupus = sysUser                         
C                   UPDATE    RETRPROD                                 
C                   ENDIF                                              
C                   SETON                                            90
C                   ELSE                                               
C                   READ      RETRPROD                               90
C                   ENDIF                                              
C                   ENDDO                                              
C     flag3         IFEQ      0                                        
C     'ERROR'       DSPLY                                              
C                   ENDIF                                              
C                   else                                               
C     'Deleted'     dsply                                              
C                   endif                                              
C                   ENDSR                                              
C*DELETE SUBRUTINE                                                     
C     DLTESR        BEGSR                                              
C                   exsr      isActive                                 
C                   if        prodDel = *off                           
C     paid          chain     trprod                                   
C                   IF        %found()                                 
C                   eval      prdets = sysTstamp                       
C                   eval      prdeus = sysUser                         
C                   update    retrprod                                 
C     'borrado'     dsply                                              
C                   ELSE                                               
C     'Id error'    DSPLY                                              
C                   ENDIF                                              
C                   else                                               
C     'Already del' dsply                                              
C                   endif                                              
C                   ENDSR                                              
C*2020/11/09