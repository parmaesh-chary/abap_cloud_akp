CLASS zakp_calculations DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
INTERFACES:if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zakp_calculations IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
TYPES t_result TYPE p LENGTH 8 DECIMALS 2.
* TYPES t_result TYPE p LENGTH 8 DECIMALS 0.
* TYPES t_result TYPE i.
DATA result TYPE t_result.
*result = 2 + 3.
* result = 2 - 3.
* result = 2 * 3.
* result = 2 / 3.
*  result = sqrt( 2 ).
 result = ipow( base = 2 exp = 3 ).
* * result = ( 8 * 7 - 6 ) / ( 5 + 4 ).
* result = 8 * 7 - 6 / 5 + 4.
out->write( result ).
  ENDMETHOD.

ENDCLASS.
