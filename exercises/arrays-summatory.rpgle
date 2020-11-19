H option(*nodebugio) dftactgrp(*no)                        
Dfillarray        pr                                       
D                                4s 0                      
D                                4s 0 value                
Darr1             s              4s 0 dim(50) inz(5)       
Darr2             s              4s 0 dim(50) inz(10)      
Darr3             s              9s 0 dim(50)              
D***                                                       
  arr3 = arr1 + arr2;                                      
  dsply (%char(arr1(1)) + ' + ' + %char(arr2(1)) + ' is ' +
         %char(arr3(1)));                                  
  *inlr = *on;                                             
C*2020/11/18                                    