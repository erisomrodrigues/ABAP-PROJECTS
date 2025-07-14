*&---------------------------------------------------------------------*
*& Report ZPROG_OOP_CX_SY_ZERODIVIDE_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_oop_cx_sy_zerodivide_eri.

DATA: v_unit_value  TYPE i,
      v_total_value TYPE i VALUE 20,
      v_quantity    TYPE i.

DATA r_ex TYPE REF TO cx_sy_zerodivide.

TRY.
    v_unit_value = v_total_value / v_quantity.


  CATCH cx_sy_zerodivide INTO r_ex.
    WRITE:/ 'Error Short Text:', r_ex->get_text( ).
    WRITE:/ 'Error long Text:', r_ex->get_longtext( ).
  CLEANUP.  
ENDTRY.
