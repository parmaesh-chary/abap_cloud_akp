*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

class lcl_connection definition.

  public section.

  DATA carrier_id TYPE /dmo/carrier_id.             ""Instance Attribute
  DATA connection_id TYPE /dmo/connection_id.       ""Instance Attribute
  CLASS-DATA conn_counter TYPE i.                   ""Static Attribute

  protected section.
  private section.

endclass.

class lcl_connection implementation.

endclass.
