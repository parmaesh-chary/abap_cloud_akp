*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_demo DEFINITION.
    PUBLIC SECTION.
    METHODS use_work_area.
    METHODS use_field_symbol.
    PRIVATE SECTION.
    TYPES t_flights TYPE STANDARD TABLE OF /dmo/flight
            WITH NON-UNIQUE KEY carrier_id connection_id flight_date.

    METHODS loop_field_symbol CHANGING c_flights TYPE t_Flights.
    METHODS loop_Work_area CHANGING c_flights TYPE t_flights.
ENDCLASS.


CLASS lcl_demo IMPLEMENTATION.

METHOD use_field_symbol.
   DATA flights TYPE t_flights.
   SELECT FROM /dmo/flight FIELDS * INTO TABLE @flights.
   loop_field_symbol( CHANGING c_flights = flights ).
ENDMETHOD.


METHOD use_work_area.
   DATA flights TYPE t_flights.
   SELECT FROM /dmo/flight FIELDS * INTO TABLE @flights.
   loop_work_area( CHANGING c_flights = flights ).
ENDMETHOD.


METHOD loop_field_symbol.
*
*FIELD-SYMBOLS <fs_temp> like line of c_flights.
*
*   LOOP AT c_flights ASSIGNING <fs_temp>.
*      <fs_temp>-seats_occupied += 1.
*   ENDLOOP.

   LOOP AT c_flights ASSIGNING FIELD-SYMBOL(<fs_data>).
      <fs_data>-seats_occupied += 1.
   ENDLOOP.
ENDMETHOD.

METHOD loop_work_area.
   LOOP AT c_flights INTO DATA(flight).
          flight-seats_occupied += 1.
          MODIFY c_flights FROM flight.
   ENDLOOP.
ENDMETHOD.

ENDCLASS.
