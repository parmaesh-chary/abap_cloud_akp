CLASS zakp_cond_branching DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zakp_cond_branching IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
  CONSTANTS c_number TYPE i VALUE 0.
* CONSTANTS c_number TYPE i VALUE 1.
* CONSTANTS c_number TYPE i VALUE 2.
* CONSTANTS c_number TYPE i VALUE -1.
* CONSTANTS c_number TYPE i VALUE -2.

out->write( `--------------------------------` ).
out->write( `Example 1: Simple IF ... ENDIF.` ).
out->write( `-------------------------------` ).

IF c_number = 0.
out->write( `The value of C_NUMBER equals zero` ).
ELSE. out->write( `The value of C_NUMBER is NOT zero` ).
ENDIF.

 out->write( `--------------------------------------------` ).
 out->write( `Example 2: Optional Branches ELSEIF and ELSE` ).
 out->write( `--------------------------------------------` ).

 IF c_number = 0. out->write( `The value of C_NUMBER equals zero` ).
 ELSEIF c_number > 0.
 out->write( `The value of C_NUMBER is greater than zero` ).
 ELSE.
 out->write( `The value of C_NUMBER is less than zero` ).
 ENDIF.

out->write( `---------------------------` ).
out->write( `Example 3: CASE ... ENDCASE` ).
out->write( `---------------------------` ).

CASE c_number.
WHEN 0.
out->write( `The value of C_NUMBER equals zero` ).
WHEN 1.
out->write( `The value of C_NUMBER equals one` ).
WHEN 2.
out->write( `The value of C_NUMBER equals two` ).
WHEN OTHERS.
out->write( `The value of C_NUMBER equals non of the above` ).
ENDCASE.


  ENDMETHOD.

ENDCLASS.
