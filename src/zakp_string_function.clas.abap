CLASS zakp_string_function DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zakp_string_function IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    DATA text   TYPE string VALUE `  Let's talk about ABAP  `.
*DATA result TYPE i.

*out->write(  text ).

*    result = find( val = text sub = 'A' ).  ""19
*    result = find( val = text sub = 'A' case = abap_false ).
*    result = find( val = text sub = 'A' case = abap_false occ =  -1 ).""Search from reverse 21
*    result = find( val = text sub = 'A' case = abap_false occ =  -2 ).
*    result = find( val = text sub = 'A' case = abap_false occ =   2 ).*
*    result = find( val = text sub = 'A' case = abap_false occ = 2 off = 10 ).""19
*    result = find( val = text sub = 'A' case = abap_false occ = 2 off = 10 len = 4 ). ""No Occurence -1

** Val = Value
** sub = search value
**case = abap_true , abap_false
** occ = occurence
**off = offset
**len = length

*out->write( |RESULT = { result } | ).

*------------------------------------------------------------------


* DATA result TYPE i.
*
*    DATA text    TYPE string VALUE `  ABAP  `.
*    DATA substring TYPE string VALUE `AB`.
*    DATA offset    TYPE i      VALUE 1.

* Call different description functions
******************************************************************************
*   result = strlen( text )."8
*    result = numofchar(  text ).""6 - Ingnore the ending blanks

*    result = count( val = text sub = substring off = offset )."1- This is count
*    result = find( val = text sub = substring off = offset ). "2 - This is offset

*    result = count_any_of( val = text sub = substring off = offset ). ""3- Individual character comparision
*    result = find_any_of(      val = text sub = substring off = offset ). "2 offset is 1

*    result = count_any_not_of( val = text sub = substring off = offset )."4
*    result = find_any_not_of(  val = text sub = substring off = offset )."1
*
*    out->write( |Text      = `{ text }`| ).
*    out->write( |Substring = `{ substring }` | ).
*    out->write( |Offset    = { offset } | ).
*    out->write( |Result    = { result } | ).


*----------------------------------------------------------------------

    DATA text TYPE string VALUE ` SAP BTP,   ABAP Environment  `.

* Change Case of characters
**********************************************************************
    out->write( |TO_UPPER   = {   to_upper(  text ) } | )."SAP BTP,   ABAP ENVIRONMENT
    out->write( |TO_LOWER   = {   to_lower(  text ) } | )."sap btp,   abap environment
    out->write( |TO_MIXED   = {   to_mixed(  text ) } | )."sap btp,   abap environment
    out->write( |FROM_MIXED = { from_mixed(  text ) } | )."_S_A_P _B_T_P,   _A_B_A_P _ENVIRONMENT


* Change order of characters
**********************************************************************
    out->write( |REVERSE             = {  reverse( text ) } | ). " tnemnorivnE PABA   ,PTB PAS
    out->write( |SHIFT_LEFT  (places)= {  shift_left(  val = text places   = 3  ) } | )."P BTP,   ABAP Environment
    out->write( |SHIFT_RIGHT (places)= {  shift_right( val = text places   = 3  ) } | )."SAP BTP,   ABAP Environmen
    out->write( |SHIFT_LEFT  (circ)  = {  shift_left(  val = text circular = 3  ) } | )."P BTP,   ABAP Environment   SA
    out->write( |SHIFT_RIGHT (circ)  = {  shift_right( val = text circular = 3  ) } | )."t   SAP BTP,   ABAP Environmen


* Extract a Substring
**********************************************************************
    out->write( |SUBSTRING       = {  substring(        val = text off = 4 len = 10 ) } | )."BTP,   AB
    out->write( |SUBSTRING_FROM  = {  substring_from(   val = text sub = 'ABAP'     ) } | )."ABAP Environment
    out->write( |SUBSTRING_AFTER = {  substring_after(  val = text sub = 'ABAP'     ) } | )."Environment
    out->write( |SUBSTRING_TO    = {  substring_to(     val = text sub = 'ABAP'     ) } | )."SAP BTP,   ABAP
    out->write( |SUBSTRING_BEFORE= {  substring_before( val = text sub = 'ABAP'     ) } | )."SAP BTP,


* Condense, REPEAT and Segment
**********************************************************************
    out->write( |CONDENSE         = {   condense( val = text ) } | )."SAP BTP, ABAP Environment
    out->write( |REPEAT           = {   repeat(   val = text occ = 2 ) } | )."SAP BTP,   ABAP Environment   SAP BTP,   ABAP Environment
    out->write( |SEGMENT1         = {   segment(  val = text sep = ',' index = 1 ) } |  )."SAP BTP
    out->write( |SEGMENT2         = {   segment(  val = text sep = ',' index = 2 ) } |  )." ABAP Environment

**REGEX

    DATA text1 TYPE string VALUE 'Date 1996-02-02 is in ISO-FORMAT'.
    DATA regex TYPE string VALUE '[0-9]{4}(-[0-9]{2}){2}'.

    IF contains( val = text1 pcre = regex ).
      DATA(number) = count( val = text1 pcre = regex ).
      DATA(offeset) = find( val = text1 pcre = regex occ = 1 ).
      DATA(data_text) = match( val = text1 pcre = regex ).

      out->write( |Number : { number }| )."1
      out->write( |offeset : { offeset }| )."5
      out->write( |data_text : { data_text }| )."1996-02-02
      IF matches( val = text1 pcre = regex ). ""True if completely matches
        out->write( 'Complete string matches with regex' ).
      ELSE.
        out->write( 'No Complete string matches with regex' ).
      ENDIF.


    ENDIF.

  ENDMETHOD.
ENDCLASS.

