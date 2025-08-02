*&---------------------------------------------------------------------*
*& Report ZPROG_TRANSLATE_UPPER_LOWER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_translate_upper_lower.

DATA: lv_upper TYPE string VALUE 'upper',
      lv_lower TYPE string VALUE 'LOWER'.

TRANSLATE lv_upper TO UPPER CASE.
TRANSLATE lv_lower TO LOWER CASE.

WRITE:/ lv_upper,
      / lv_lower.
ULINE.

WRITE:/ to_upper( lv_upper ),
      / to_lower( lv_lower ).
ULINE.
