CLASS zakp_iterations DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES:IF_OO_ADT_CLASSRUN.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zakp_iterations IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
CONSTANTS c_number TYPE i VALUE 3.
* CONSTANTS c_number TYPE i VALUE 5.
* CONSTANTS c_number TYPE i VALUE 10.
DATA number TYPE i.

out->write( `----------------------------------` ).
out->write( `Example 1: DO ... ENDDO with TIMES` ).
out->write( `----------------------------------` ).

DO c_number TIMES.
out->write( `Hello World` ).
ENDDO.

out->write( `-------------------------------` ).
out->write( `Example 2: With Abort Condition` ).
out->write( `-------------------------------` ).
number = c_number * c_number.
" count backwards from number to c_number.
DO.
out->write( |{ sy-index }: Value of number: { number }| ).
number = number - 1.
"abort condition
IF number <= c_number.
EXIT.
ENDIF.
ENDDO.

ENDMETHOD.

ENDCLASS.

*oUTPUT
*----------------------------------
*Example 1: DO ... ENDDO with TIMES
*----------------------------------
*Hello World
*Hello World
*Hello World
*-------------------------------
*Example 2: With Abort Condition
*-------------------------------
*1: Value of number: 9
*2: Value of number: 8
*3: Value of number: 7
*4: Value of number: 6
*5: Value of number: 5
*6: Value of number: 4



