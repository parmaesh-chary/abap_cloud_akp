CLASS zakp_conversion DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES : if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zakp_conversion IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

  data my_int type i .
  data my_pack type p LENGTH  8 DECIMALS 2.
  data my_char10 type c LENGTH 10 value 'abcdefghij'.
  data my_char4 type c LENGTH 4 value 'abcd'.
  data my_string type string.

 my_int = '1234'.       ""c->i
 my_pack = '-273.34'.   ""C--> P
*MY_INT = my_char4.     ""C --> i -- Runtime error
 my_char4 = my_char10. ""CHAR 10 TO CHAR4 --Data loss
 my_string = 'hELLO'.


 OUT->write( my_int ).
 OUT->write( my_pack ).
 OUT->write( my_char4 ).
 OUT->write( my_char10 ).
 OUT->write( my_string ).

  ENDMETHOD.

ENDCLASS.
