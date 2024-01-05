CLASS zakp_string_proc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES:if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zakp_string_proc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
TYPES t_amount TYPE p LENGTH 8 DECIMALS 2.
DATA amount TYPE t_amount VALUE '3.30'.
DATA amount1 TYPE t_amount VALUE '1.20'.
DATA amount2 TYPE t_amount VALUE '2.10'.
DATA the_date TYPE d VALUE '19891109'.
DATA my_number TYPE p LENGTH 3 DECIMALS 2 VALUE '-273.15'.
DATA part1 TYPE string VALUE `Hello`.
DATA part2 TYPE string VALUE `World`.

*DATA(text) = |Hello World|.
* DATA(text) = |Total: { amount } EUR|.
* DATA(text) = |Total: { amount1 + amount2 } EUR|.

*DATA(text) = |Raw Date: { the_date }|.  ""Raw Date: 19891109

"Date
* DATA(text) = |ISO Date: { the_date Date = ISO }|.""ISO Date: 1989-11-09
* DATA(text) = |USER Date:{ the_date Date = USER }|. ""USER Date:11/09/1989

"Number
* DATA(text) = |Raw Number { my_number }|.
* DATA(text) = |User Format{ my_number NUMBER = USER }|.
* DATA(text) = |Sign Right { my_number SIGN = RIGHT }|.  ""Sign Right 273.15-
* DATA(text) = |Scientific { my_number STYLE = SCIENTIFIC }|.

*DATA(text) = part1 && part2.
 DATA(text) = part1 && | | && part2.
* DATA(text) = |{ amount1 } + { amount2 } && { amount1 + amount2 }|.

out->write( text ).

  ENDMETHOD.

ENDCLASS.
