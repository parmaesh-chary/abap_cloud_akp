CLASS zakp_sql_literals DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zakp_sql_literals IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
     CONSTANTS c_number TYPE i VALUE 1234.

*Example -1
**********************************************************************
        SELECT SINGLE FROM /dmo/carrier
             FIELDS 'Hello'    AS Character,    " Type c
                     1         AS Integer1,     " Type i
                    -1         AS Integer2,     " Type i
                    @c_number as constant
                    into @data(it_tab).

         out->write(
           EXPORTING
             data   = it_tab
*             name   =
*           RECEIVING
*             output =
         ).

*Example - 2 - Case operator
**********************************************************************
         SELECT SINGLE FROM /DMO/CARRIER
            FIELDS '19891101' as  char_8,
            CAST( '19891101' as CHAR( 4 ) ) as char_4,
            CAST( '19891101' as NUMC( 8 ) ) AS numc_8, "The conversion to numeric types (INT4, DEC, FLTP) leads to runtime errors if the source literal contains non-digit characters
            CAST( '19891101' as int4 ) as integer,
            CAST( '19891101' as dec( 10 , 1 ) ) as dec_10_2,
            cast( '19891101' as fltp ) as fltp,
            cast( '19891101' as dats ) as date
            into @data(result).

            out->write(
              EXPORTING
                data   = result
*                name   =
*              RECEIVING
*                output =
            ).

*Example - 3 - Case
**********************************************************************
        SELECT FROM /dmo/customer
                FIELDS customer_id,
                        title,
                    CASE title
                        WHEN 'Mr.'  THEN 'Mister'
                        WHEN 'Mrs.' THEN 'Misses'
                    end as abbrevation,
                    CASE
                    when title = 'Mr.' or title = 'Ms.' then 'Bachelor'
                    when title = 'Mrs.' then 'Married'
                    end as relationship
        into table @data(cust_table)
        UP TO 10 ROWS.

        out->write(
                EXPORTING
                data   = cust_table
*    name   =
*  RECEIVING
*    output =
).


*Example - 4 - Expressions
**********************************************************************
SELECT FROM /dmo/flight
       FIELDS seats_max,
              seats_occupied,
              seats_max - seats_occupied AS seats_avaliable,
              ( CAST( seats_occupied AS FLTP ) * CAST( 100 AS FLTP ) ) / CAST(  seats_max AS FLTP ) AS percentage_fltp
       WHERE carrier_id = 'LH' AND connection_id = '0400'
       INTO TABLE @DATA(result_1).

       out->write(
        EXPORTING
           data   = result_1
           name   = 'RESULT'
       ).

*Example-5 - Arithmetic Functions
**********************************************************************
        SELECT FROM /dmo/flight
                FIELDS seats_max,
                    seats_occupied,
                    ( CAST( seats_occupied AS FLTP ) * CAST( 100 AS FLTP ) ) / CAST(  seats_max AS FLTP ) AS percentage_fltp,
                    div( seats_occupied * 100 , seats_max ) AS percentage_int,
                    division(  seats_occupied * 100, seats_max, 2 ) AS percentage_dec,
                    div( seats_max ,seats_occupied ) as div_act,
                    mod( seats_max ,seats_occupied ) as mod_act
               WHERE carrier_id    = 'LH'
               AND connection_id = '0400'
               INTO TABLE @DATA(result_2).

       out->write(
         EXPORTING
           data   = result_2
           name   = 'RESULT'
       ).

*Example-6 - String Operations
**********************************************************************
        SELECT FROM /dmo/customer
                FIELDS customer_id,
                    street && ',' && ' ' && postal_code && ' ' && city   AS address_expr,
                    concat( street,concat_with_space( ',',concat_with_space( postal_code,upper(  city ),1 ),1 ) ) AS address_func
             WHERE country_code = 'ES'
              INTO TABLE @DATA(result_concat) up to 10 ROWS.

       out->write(
         EXPORTING
           data   = result_concat
           name   = 'RESULT_CONCAT'
       ).

       ""concat( string1 , string 2)
       ""concat_with_space(string1,string2,no.ofspacesbetweenthem)
*Example-7
**********************************************************************
        SELECT FROM /dmo/carrier
                FIELDS  carrier_id,
                        name,
                        upper( name )   AS name_upper,
                        lower( name )   AS name_lower,
                        initcap( name ) AS name_initcap
                WHERE carrier_id = 'SR'
                INTO TABLE @DATA(result_transform).
       out->write(
         EXPORTING
           data   = result_transform
           name   = 'RESULT_TRANSLATE'
       ).
**
**RESULT_TRANSLATE
**CARRIER_ID    NAME            NAME_UPPER      NAME_LOWER      NAME_INITCAP
**SR            Sundair GmbH    SUNDAIR GMBH    sundair gmbh    Sundair Gmbh
*
***********************************************************************
*            SELECT FROM /dmo/flight
*                    FIELDS flight_date,
*                    cast( flight_date as char( 8 ) )  AS flight_date_raw,
*                    left( flight_Date, 4   )          AS year,
*                    right(  flight_date, 2 )          AS day,
*                    substring(  flight_date, 5, 2 )   AS month
*                    WHERE carrier_id = 'LH'
*                            AND connection_id = '0400'
*                    INTO TABLE @DATA(result_substring).
*
*       out->write(
*         EXPORTING
*           data   = result_substring
*           name   = 'RESULT_SUBSTRING'
*       ).
**
**RESULT_SUBSTRING
**FLIGHT_DATE    FLIGHT_DATE_RAW    YEAR    DAY    MONTH
**2024-08-24     20240824           2024    24     08
**2023-10-29     20231029           2023    29     10
*
***********************************************************************
**BuiltIn Functions - Date , Time , Timestamp
*
*
*       SELECT FROM /dmo/travel
*                FIELDS begin_date,
*                    end_date,
*                    is_valid( begin_date  )              AS valid,
*                    add_days( begin_date, 7 )            AS add_7_days,
*                    add_months(  begin_date, 3 )         AS add_3_months,
*                    days_between( begin_date, end_date ) AS duration,
*                    weekday(  begin_date  )              AS weekday,
*                    extract_month(  begin_date )         AS month,
*                    dayname(  begin_date )               AS day_name
**                WHERE customer_id = '000001'
**                AND days_between( begin_date, end_date ) > 10
*                INTO TABLE @DATA(result_dat) up to 10 rows.
*
*       out->write(
*         EXPORTING
*           data   = result_dat
*           name   = 'RESULT-Built in Function'
*       ).
*
************************************************************************
*            SELECT FROM /dmo/travel
*                    FIELDS lastchangedat,
*                    CAST( lastchangedat AS DEC( 15,0 ) ) AS latstchangedat_short,
*                    tstmp_to_dats( tstmp = CAST( lastchangedat AS DEC( 15,0 ) ),
*                                   tzone = CAST( 'EST' AS CHAR( 6 ) )
*                                 ) AS date_est,
*                    tstmp_to_tims( tstmp = CAST( lastchangedat AS DEC( 15,0 ) ),
*                                  tzone = CAST( 'EST' AS CHAR( 6 ) )
*                                ) AS time_est
*             WHERE customer_id = '000001'
*              INTO TABLE @DATA(result_date_time).
*
*       out->write(
*         EXPORTING
*           data   = result_date_time
*           name   = 'RESULT_DATE_TIME'
*       ).
************************************************************************
**        DATA(today) = cl_abap_context_info=>get_system_date(  ).
**
**       SELECT FROM /dmo/travel
**            FIELDS total_price,
**                   currency_code,
**                   currency_conversion( amount             = total_price,
**                                        source_currency    = currency_code,
**                                        target_currency    = 'EUR',
**                                        exchange_rate_date = @today
**                                      ) AS total_price_EUR
**                WHERE customer_id = '000001' AND currency_code <> 'EUR'
**              INTO TABLE @DATA(result_currency).
**
**       out->write(
**         EXPORTING
**           data   = result_currency
**           name   = 'RESULT__CURRENCY'
**       ).
**
**
************************************************************************
*
*       SELECT FROM /dmo/connection
*            FIELDS distance,
*                   distance_unit,
*                   unit_conversion( quantity = CAST( distance AS QUAN ),
*                                    source_unit = distance_unit,
*                                    target_unit = CAST( 'MI' AS UNIT ) )  AS distance_MI
*             WHERE airport_from_id = 'FRA'
*              INTO TABLE @DATA(result_unit).
*
*       out->write(
*         EXPORTING
*           data   = result_unit
*           name   = 'RESULT_UNIT'
*       ).
***********************************************************************
**Example- Order By
*        SELECT FROM /dmo/flight
*             FIELDS carrier_id,
*                    connection_id,
*                    flight_date,
*                    seats_max - seats_occupied AS seats
*              WHERE carrier_id     = 'AA'
*                AND plane_type_id  = 'A320-200'
*       ORDER BY seats_max - seats_occupied DESCENDING,
*                flight_date                ASCENDING
*              INTO TABLE @DATA(result_order).
*
*       out->write(
*         EXPORTING
*           data   = result_order
*           name   = 'RESULT'
*       ).
***********************************************************************
**Example - Distinct
*
*SELECT FROM /dmo/connection
*        FIELDS
*           DISTINCT
*               airport_from_id,
*               distance_unit
*      ORDER BY airport_from_id DESCENDING,distance_unit ASCENDING
*          INTO TABLE @DATA(result_distinct).
*
*       out->write(
*         EXPORTING
*           data   = result_distinct
*           name   = 'RESULT'
*       ).
*
***********************************************************************
**Example - Group By - Aggregation
*    SELECT FROM /dmo/connection
*         FIELDS
*           carrier_id,
*                MAX( distance ) AS max,
*               MIN( distance ) AS min,
*                SUM( distance ) AS sum,
*                COUNT( * ) AS count
*     GROUP BY carrier_id
*     ORDER BY count,sum DESCENDING
*        INTO TABLE @DATA(result_group).
*       out->write(
*         EXPORTING
*           data   = result_group
*           name   = 'RESULT'
*       ).
*
***********************************************************************
**Example - Inner Joins
*
*SELECT FROM /dmo/carrier INNER JOIN /dmo/connection
**    SELECT FROM /dmo/carrier AS a INNER JOIN /dmo/connection AS c
*                 ON /dmo/carrier~carrier_id = /dmo/connection~carrier_id
*             FIELDS /dmo/carrier~carrier_id,
*                    /dmo/carrier~name AS carrier_name,
*                    /dmo/connection~connection_id,
*                    /dmo/connection~airport_from_id,
*                   /dmo/connection~airport_to_id
*             WHERE /dmo/carrier~currency_code = 'EUR'
*              INTO TABLE @DATA(result_inner).
*
*       out->write(
*        EXPORTING
*           data   = result_Inner
*           name   = 'RESULT_Inner'
*       ).
*
**Self Join
*
**FRA to destination via mulitple alts
*
*        Select from  /dmo/connection as a
*                INNER JOIN /dmo/connection as b
*                on a~airport_to_id = b~airport_from_id
*                FIELDS
*                a~airport_from_id,
*                CONCAT_WITH_SPACE( a~carrier_id,a~connection_id,1 ) as first_leg,
*                a~airport_to_id as via_airport_id,
*                CONCAT_WITH_SPACE( b~carrier_id,b~connection_id,1 ) as second_leg,
*                b~airport_to_id
*                where a~airport_from_id = 'FRA'
*                INTO TABLE @DATA(ITAB_SELFJOIN).
*                out->write(
*                  EXPORTING
*                    data   = itab_selfjoin
**                    name   =
**                  RECEIVING
**                    output =
*                ).
***********************************************************************
**Left , right outer join
*        SELECT FROM /dmo/Agency AS a
**                   INNER JOIN /dmo/customer AS c
**           LEFT OUTER JOIN /dmo/customer AS c
*          RIGHT OUTER JOIN /dmo/customer AS c
*                 ON a~city         = c~city
*             FIELDS agency_id,
*                    name AS Agency_name,
*                   a~city AS agency_city,
*                   c~city AS customer_city,
*                  customer_id,
*                   last_name AS customer_name
*             WHERE ( c~customer_id < '000010' OR c~customer_id IS NULL )
*               AND ( a~agency_id   < '070010' OR a~agency_id   IS NULL )
*              INTO TABLE @DATA(result_Join_all).
*      out->write(
*         EXPORTING
*          data   = result_join_all
*           name   = 'RESULT_JOIN_all'
*       ).
*
**Output
***Inner join
**RESULT_JOIN_all
**AGENCY_ID    AGENCY_NAME    AGENCY_CITY    CUSTOMER_CITY    CUSTOMER_ID    CUSTOMER_NAME
**070005       Your Choice    Nuernberg      Nuernberg        000003         Buchholm
*
****Left outer join
**RESULT_JOIN_all
**AGENCY_ID    AGENCY_NAME            AGENCY_CITY    CUSTOMER_CITY    CUSTOMER_ID    CUSTOMER_NAME
**070007       Hot Socks Travel       Sydney                          000000
**070005       Your Choice            Nuernberg      Nuernberg        000003         Buchholm
**070002       MODIFIED Agency        Duesseldorf                     000000
**070001       MODIFIED Agency        Rochester                       000000
**070004       Testing                Frankfurt                       000000
**070009       Honauer Reisen GmbH    Neumarkt                        000000
**070008       Burns Nuclear          Singapore                       000000
*
****Right outer join
**AGENCY_ID    AGENCY_NAME    AGENCY_CITY    CUSTOMER_CITY        CUSTOMER_ID    CUSTOMER_NAME
**070005       Your Choice    Nuernberg      Nuernberg            000003         Buchholm
**000000                                     Gaertringen          000001         Buchholm
**000000                                     Karlsruhe            000009         Buchholm
**000000                                     Seeheim-Jugenheim    000008         Buchholm
**000000                                     Elsenz               000006         Buchholm
**000000                                     Linz                 000005         Buchholm
**000000                                     Neu-Isenburg         000004         Buchholm
**000000                                     Schwetzingen         000002         Buchholm
*
*
*


 ENDMETHOD.
ENDCLASS.

