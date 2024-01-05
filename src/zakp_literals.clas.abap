CLASS zakp_literals DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES : if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zakp_literals IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
 TYPES my_type TYPE p LENGTH 3 DECIMALS 2.
* TYPES my_type TYPE i .
* TYPES my_type TYPE string.
* TYPES my_type TYPE n length 10.
* Variable based on local type
DATA my_variable TYPE my_type.
out->write( `my_variable (TYPE MY_TYPE)` ).
out->write( my_variable ).

******
DATA airport TYPE /dmo/airport_id VALUE 'FRA'.
out->write( `airport (TYPE /DMO/AIRPORT_ID )` ).
out->write( airport ).

*******

CONSTANTS c_text TYPE string VALUE `Hello World`.
CONSTANTS c_number TYPE i VALUE 12345.
"Uncomment this line to see syntax error ( VALUE is mandatory)
*constants c_text2 type string.
out->write( `c_text (TYPE STRING)` ).
out->write( c_text ).
out->write( '---------' ).
out->write( `c_number (TYPE I )` ).
out->write( c_number ).
out->write( `---------` ).

************
out->write( '12345 ' ).
"Text Literal (Type C)
out->write( `12345 ` ).
"String Literal (Type STRING)
out->write( 12345 ).
"Number Literal (Type I) "uncomment this line to see syntax error (no number literal with digits)
*out->write( 12345.67 ).

ENDMETHOD.

ENDCLASS.
