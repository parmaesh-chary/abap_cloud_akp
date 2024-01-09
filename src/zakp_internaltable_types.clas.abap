CLASS zakp_internaltable_types DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zakp_internaltable_types IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF st_carrier,
           carrier_id TYPE /dmo/carrier_id,
           currency_code TYPE /dmo/currency_code,
            END OF st_carrier.
    DATA carriers TYPE STANDARD TABLE OF st_carrier WITH NON-UNIQUE KEY carrier_id.
*   DATA carriers TYPE STANDARD TABLE OF st_carrier WITH UNIQUE KEY carrier_id. "UNIQUE can only be specified with the table categories HASHED and SORTED.
    DATA carrier LIKE LINE OF carriers.

  carriers = VALUE #( ( carrier_id = 'SQ' currency_code = 'INR' )
                        ( carrier_id = 'SQ' currency_code = 'INR' )
                        ( carrier_id = 'JL' currency_code = 'EUR' )
                        ( carrier_id = 'AA' currency_code = 'EUD' )
                        ( carrier_id = 'UA' currency_code = 'AUD' ) ).

           carrier-carrier_id = 'KK'.
           carrier-currency_code = 'INR'.

           insert carrier into table carriers.

           carrier-carrier_id = 'MM'.
           carrier-currency_code = 'INR'.

           APPEND CARRIER TO CARRIERS.
*
        out->write( carriers ).
*
   TYPES: BEGIN OF st_connection,
            carrier_id TYPE /dmo/carrier_id,
            connection_id TYPE /dmo/connection_id,
            airport_from_id TYPE /dmo/airport_from_id,
            airport_to_id TYPE /dmo/airport_to_id,
            carrier_name TYPE /dmo/carrier_name,
            END OF st_connection.
    TYPES tt_connections TYPE SORTED TABLE OF st_connection WITH NON-UNIQUE KEY carrier_id connection_id.
    DATA connections TYPE tt_connections.
    DATA connection LIKE LINE OF connections.


    connections = VALUE #( ( carrier_id = 'JL' connection_id = '0408' airport_from_id = 'FRA' airport_to_id = 'NRT' carrier_name = 'Japan Airlines' )
                        ( carrier_id = 'JL' connection_id = '0409' airport_from_id = 'FRA' airport_to_id = 'NRT' carrier_name = 'Japan Airlines' )
                        ( carrier_id = 'JL' connection_id = '0408' airport_from_id = 'FRA' airport_to_id = 'NRT' carrier_name = 'Japan Airlines' )
                        ( carrier_id = 'AA' connection_id = '0017' airport_from_id = 'MIA' airport_to_id = 'HAV' carrier_name = 'American Airlines' )
                        ( carrier_id = 'SQ' connection_id = '0001' airport_from_id = 'SFO' airport_to_id = 'SIN' carrier_name = 'Singapore Airlines' )
                        ( carrier_id = 'UA' connection_id = '0078' airport_from_id = 'SFO' airport_to_id = 'SIN' carrier_name = 'United Airlines' ) ).


connection-carrier_id = 'KK'.
connection-connection_id = '0411'.
connection-airport_from_id = 'FRA' .
connection-airport_to_id = 'NRT' .
connection-carrier_name = 'Japan Airlines'.

insert connection into table connections.


""Illegel sort order exception
*connection-carrier_id = 'MM'.
*connection-connection_id = '0422'.
*connection-airport_from_id = 'FRA' .
*connection-airport_to_id = 'NRT' .
*connection-carrier_name = 'Japan Airlines'.
*
*append connection to connections.


    out->write(
      EXPORTING
        data   = connections
        name   = 'Sorter table with Non Unique'
*      RECEIVING
*        output =
    ).
    TYPES tt_connections_uniq TYPE SORTED TABLE OF st_connection WITH UNIQUE KEY carrier_id connection_id.
    DATA connections_uniq TYPE tt_connections_uniq.
    DATA connection_uniq LIKE LINE OF connections.
***ITAB_DUPLICATE_KEY runtime error
*    connections_uniq = VALUE #(
*                        ( carrier_id = 'JL' connection_id = '0408' airport_from_id = 'FRA' airport_to_id = 'NRT' carrier_name = 'Japan Airlines' )
*                        ( carrier_id = 'JL' connection_id = '0408' airport_from_id = 'FRA' airport_to_id = 'NRT' carrier_name = 'Japan Airlines' )
*                        ( carrier_id = 'AA' connection_id = '0017' airport_from_id = 'MIA' airport_to_id = 'HAV' carrier_name = 'American Airlines' )
*                        ( carrier_id = 'SQ' connection_id = '0001' airport_from_id = 'SFO' airport_to_id = 'SIN' carrier_name = 'Singapore Airlines' )
*                        ( carrier_id = 'UA' connection_id = '0078' airport_from_id = 'SFO' airport_to_id = 'SIN' carrier_name = 'United Airlines' ) ).

* connections_uniq = VALUE #(
*                        ( carrier_id = 'JL' connection_id = '0408' airport_from_id = 'FRA' airport_to_id = 'NRT' carrier_name = 'Japan Airlines' )
*                        ( carrier_id = 'JL' connection_id = '0409' airport_from_id = 'FRA' airport_to_id = 'NRT' carrier_name = 'Japan Airlines' )
*                        ( carrier_id = 'AA' connection_id = '0017' airport_from_id = 'MIA' airport_to_id = 'HAV' carrier_name = 'American Airlines' )
*                        ( carrier_id = 'SQ' connection_id = '0001' airport_from_id = 'SFO' airport_to_id = 'SIN' carrier_name = 'Singapore Airlines' )
*                        ( carrier_id = 'UA' connection_id = '0078' airport_from_id = 'SFO' airport_to_id = 'SIN' carrier_name = 'United Airlines' ) ).
*    out->write(
*      EXPORTING
*        data   = connections_uniq
*        name   = 'Sorted table with Unique'
**      RECEIVING
**        output =
*    ).

     TYPES: BEGIN OF st_connection_ha,
            carrier_id TYPE /dmo/carrier_id,
            connection_id TYPE /dmo/connection_id,
            END OF st_connection_ha.
*
*    types tt_conn_hash type HASHED TABLE OF st_connection_ha WITH UNIQUE key carrier_id.
**   types tt_conn_hash type HASHED TABLE OF st_connection_ha WITH NON-UNIQUE key carrier_id. ""HASHED keys must be unique. The addition UNIQUE must be specified.
*    DATA connections_hash TYPE tt_conn_hash.
*    DATA connection_hash LIKE LINE OF connections_hash.
*""ITAB_DUPLCATE Runtime Error - Because Carrier id is only the Key
*    connections_hash = value #( ( carrier_id = 'JL' connection_id = '0408' )
*                                ( carrier_id = 'JL' connection_id = '0409' )
*                                ( carrier_id = 'JL' connection_id = '0410' )
*                                ( carrier_id = 'JL' connection_id = '0411' )
*                                ).


    types tt_conn_hash type HASHED TABLE OF st_connection_ha WITH UNIQUE key carrier_id connection_id.
*   types tt_conn_hash type HASHED TABLE OF st_connection_ha WITH NON-UNIQUE key carrier_id. ""HASHED keys must be unique. The addition UNIQUE must be specified.
    DATA connections_hash TYPE tt_conn_hash.
    DATA connection_hash LIKE LINE OF connections_hash.

    connections_hash = value #( ( carrier_id = 'JL' connection_id = '0408' )
                                ( carrier_id = 'JL' connection_id = '0410' )
                               ( carrier_id = 'JL' connection_id = '0409' )
                                ( carrier_id = 'JL' connection_id = '0411' )
                                ).

   connection_hash-carrier_id = 'AA'.
   connection_hash-connection_id = '1111'.
   insert connection_hash into table connections_hash.




    OUT->write(
      EXPORTING
        data   = connections_hash
        name   = 'Hash table'
*      RECEIVING
*        output =
    ).

  ENDMETHOD.
ENDCLASS.
