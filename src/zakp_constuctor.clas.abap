CLASS zakp_constuctor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES:IF_OO_ADT_CLASSRUN.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zakp_constuctor IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

*First Object
    connection = NEW #( ).
    TRY.
    connection->set_attributes( EXPORTING i_carrier_id = 'LH' i_connection_id = '0400' ).
    APPEND connection TO connections.
    CATCH cx_abap_invalid_value.
    out->write( `Method call failed` ).
    ENDTRY.
* connection->carrier_id = 'LH'.
* connection->connection_id = '0400'.
* APPEND connection TO connections.

*Second Object
    connection = NEW #( ).
    TRY.
    connection->set_attributes( EXPORTING i_carrier_id = 'AA' i_connection_id = '0017' ).
    APPEND connection TO connections.
    CATCH cx_abap_invalid_value.
    out->write( `Method call failed` ).
    ENDTRY.
* connection->carrier_id = 'AA'.
* connection->connection_id = '0017'.
* APPEND connection TO connections

*Third Object
    connection = NEW #( ).
    TRY.
    connection->set_attributes( EXPORTING i_carrier_id = 'SQ' i_connection_id = '0001' ).
    APPEND connection TO connections.
    CATCH cx_abap_invalid_value.
    out->write( `Method call failed` ).
    ENDTRY.
* connection->carrier_id = 'SQ'.
* connection->connection_id = '0001'.
* * APPEND connection TO connections.

    LOOP AT connections INTO connection.
    out->write( connection->get_output( ) ).
    ENDLOOP.

ENDMETHOD.

ENDCLASS.

*OUTPUT:
*------------------------------
*Carrier: LH
*Connection: 0400
*------------------------------
*Carrier: AA
*Connection: 0017
*------------------------------
*Carrier: SQ
*Connection: 0001
