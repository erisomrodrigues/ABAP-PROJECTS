*&---------------------------------------------------------------------*
*& Report ZPROG_CASE_WITH_SELECT_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_case_with_select_eri.

TABLES: ekko.
SELECT-OPTIONS : s_ebeln FOR ekko-ebeln.

SELECT ebeln, aedat, ernam, spras,
  CASE spras
  WHEN 'P' THEN 'PT'
  WHEN 'E' THEN 'EN'
  ELSE 'Other' END AS location
 UP TO 1000 ROWS
  FROM ekko
  INTO TABLE @DATA(lt_ekko)
 WHERE ebeln IN @s_ebeln.

cl_demo_output=>display( lt_ekko ).
