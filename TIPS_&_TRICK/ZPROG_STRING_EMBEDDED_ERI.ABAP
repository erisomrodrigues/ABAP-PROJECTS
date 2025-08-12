*&---------------------------------------------------------------------*
*& Report ZPROG_STRING_EMBEDDED_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_string_embedded_eri.

DATA: lv_date          TYPE string,
      lv_time          TYPE string,
      lv_amount        TYPE p DECIMALS 2 VALUE '100',
      lv_amount_string TYPE string,
      lv_width         TYPE string,
      lv_alpha         TYPE string.

lv_date = |Date: { sy-datum DATE = USER }|.
lv_time = |Time: { sy-uzeit TIME = USER }|.
lv_amount_string = |Amount: { lv_amount CURRENCY = 'BRL' }|.
lv_width = |{ 'Plese Subscribe. Thank you.' WIDTH = 30 ALIGN = RIGHT }|.
lv_alpha = |{ '123' ALPHA = IN WIDTH = 30 }|.

WRITE: / lv_date.
WRITE: / lv_time.
WRITE: / lv_amount_string.
WRITE: / lv_width.
WRITE: / lv_alpha.
