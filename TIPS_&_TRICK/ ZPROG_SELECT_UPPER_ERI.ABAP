*&---------------------------------------------------------------------*
*& Report ZPROG_SELECT_UPPER_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_select_upper_eri.

TYPES: BEGIN OF gty_name,
         partner TYPE bu_partner,
         name    TYPE bu_name1tx,
       END OF gty_name.

DATA: lt_names      TYPE STANDARD TABLE OF gty_name,
      lv_name_upper TYPE but000-name_org1.

CONSTANTS: lc_name TYPE But000-name_org1 VALUE 'teste'.

lv_name_upper = to_upper( lc_name ).

SELECT partner,name_org1 FROM but000
 WHERE upper( name_org1 ) = @lv_name_upper
* WHERE name_org1 = @lv_name_upper
  INTO TABLE @lt_names
    UP TO 100 ROWS.
IF sy-subrc = 0.
  cl_demo_output=>display( lt_names ).
ENDIF.
