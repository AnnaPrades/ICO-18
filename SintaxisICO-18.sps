* Encoding: UTF-8.
**index_c. 
RECODE
  tipcontr
  (5=0)  (1 thru 2=3)  INTO  index_c .
execute.
DO IF (durcontr = 3) .
RECODE
  tipcontr
  (3=2)  INTO  index_c.
END IF .
execute.
DO IF (durcontr = 2) .
RECODE
  tipcontr
  (3=1.5)  INTO  index_c .
END IF .
execute.
DO IF (durcontr = 1) .
RECODE
  tipcontr
  (3=1)  INTO  index_c .
END IF .
execute.
VARIABLE LABELS index_c 'Tipus i durada contracte'.

*index_r.
RECODE
  guanys
  (1=0)  (2=0.5)  (3 thru 4=1)  (5 thru 6=2)  (7 thru 9=3)  INTO  index_r.
VARIABLE LABELS index_r 'Retribució econòmica'.
EXECUTE .

*index_s.
RECODE
  satisf5
  (1=0.5)  (4=1)  (7=1.5)  (2 thru 3=0.75)  (5 thru 6=1.25)  INTO  index_s .
VARIABLE LABELS index_s 'Satisfacció general'.
EXECUTE .

*index_a.
Do IF (IL_any>2014).
Compute index_a_nou=$sysmis.
IF (requisit=1 AND funprop1=1)  index_a_nou=3.
IF (requisit=1 AND funprop2=1)  index_a_nou=2.5.
IF (requisit=1 AND funprop2=0)  index_a_nou=0.5.
IF (requisit=2 AND funprop1=1)  index_a_nou=2.5.
IF (requisit=2 AND funprop2=1)  index_a_nou=1.5.
IF (requisit=2 AND funprop2=0)  index_a_nou=0.5.
IF (requisit=3 AND funprop1=1)  index_a_nou=2.
IF (requisit=3 AND funprop2=1)  index_a_nou=1.5.
IF (requisit=3 AND funprop2=0)  index_a_nou=0.
End if. 
VARIABLE LABELS index_a_nou 'Adequació'.
Execute.

**ICO-19 aux. 
Do IF (IL_any>2014).
COMPUTE index_iqo_aux_nou = ((index_c + index_r + index_a_nou) * index_s) * 100.
VAR LAB index_iqo_aux_nou  "Índex final".
End if. 
EXECUTE .

*ICO-19.
Do IF (IL_any>2014).
COMPUTE index_IQO_nou =  index_iqo_aux_nou  * 100/1350 .
VAR LAB index_IQO_nou "Índex IQO versio nova". 
End if.
EXECUTE .
