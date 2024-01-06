CLASS zakp_localclass DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zakp_localclass IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
  DATA connection TYPE REF TO lcl_connection.
  connection = new #( ).
  connection->carrier_id = 'LH'.
  connection->connection_id = '0400'.
  ENDMETHOD.
ENDCLASS.
