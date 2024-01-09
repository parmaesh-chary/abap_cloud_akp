CLASS zakp_table_comprehension DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zakp_table_comprehension IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  types : begin of ty_final,
          carrier_id type /dmo/carrier_id,
          connection_id type /dmo/connection_id,
          departure_airport type /dmo/airport_from_id,
          departure_airport_name type /dmo/airport_name,
          end of ty_final.
   types : tt_final type TABLE of ty_final.
   data : it_final type tt_final,
          it_connection type table of  /dmo/connection,
          it_airports type table of /dmo/airport.
* Aim of the method:
* Read a list of connections from the database and use them to fill an internal table it_final.
* This contains some data from the table connections and adds the name of the departure airport.

    select from /dmo/connection
        FIELDS * into TABLE @it_connection.

    select from /dmo/airport
        FIELDS * into TABLE @it_airports.
* The VALUE expression iterates over the table connections. In each iteration, the variable line
* accesses the current line. Inside the parentheses, we build the next line of result_table by
* copying the values of line-carrier_Id, line-connection_Id and line-airport_from_id, then
* loooking up the airport name in the internal table airports using a table expression

    it_final = VALUE #( for line in it_connection (
                      carrier_id = line-carrier_id
                      connection_id = line-connection_id
                      departure_airport = line-airport_from_id
                      departure_airport_name = it_airports[ airport_id = line-airport_from_id ]-name ) ).

        out->write(
      EXPORTING
        data   =  it_connection
        name   = 'Connection Table'
*      RECEIVING
*        output =
    ).       out->write(
      EXPORTING
        data   =  it_airports
        name   = 'Airport Table'
*      RECEIVING
*        output =
    ).

       out->write(
      EXPORTING
        data   =  it_final
        name   = 'Final table'
*      RECEIVING
*        output =
    ).


  ENDMETHOD.
ENDCLASS.
