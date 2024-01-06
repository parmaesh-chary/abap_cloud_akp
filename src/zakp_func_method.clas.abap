CLASS zakp_func_method DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zakp_func_method IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA connection TYPE REF TO lcl_connection.
  DATA connections TYPE TABLE OF REF TO lcl_connection.

  connection = NEW #( ).
  connection->set_attributes( EXPORTING i_carrier_id = 'LH' i_connection_id = '0400' ).
  APPEND connection TO connections.

 DATA(result) = connection->get_output( ).
 " in logical expression
 IF connection->get_output( ) IS NOT INITIAL.
     " as operand in a statement
    LOOP AT connection->get_output( ) INTO DATA(line).
    ENDLOOP.
    " to supply input parameter of another method
        out->write( data = connection->get_output( ) name = ` ` ).
 ENDIF.
  ENDMETHOD.
ENDCLASS.
