*&---------------------------------------------------------------------*
*& Report ZPROG_NEW_SYNTAX_TEXT_LOG_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_new_syntax_text_log_eri.

DATA: lt_final TYPE TABLE OF string,
      temp     TYPE string.

SELECT matnr,mtart,matkl,ersda
  FROM mara
  INTO TABLE @DATA(lt_mara) UP TO 100 ROWS.

LOOP AT lt_mara INTO DATA(ls_mara).
  lt_final = VALUE #( BASE lt_final ( repeat( val = '-' occ = 65 ) ) ).

  temp = |{ temp }\|{ ls_mara-matnr WIDTH = 15 ALIGN = CENTER }|.
  temp = |{ temp }\|{ ls_mara-mtart WIDTH = 15 ALIGN = CENTER }|.
  temp = |{ temp }\|{ ls_mara-matkl WIDTH = 15 ALIGN = CENTER }|.
  temp = |{ temp }\|{ ls_mara-ersda WIDTH = 15 ALIGN = CENTER }|.
*  temp = |{ temp }\|\N|.

  lt_final = VALUE #( BASE lt_final ( temp ) ).

  CLEAR temp.
ENDLOOP.

CALL FUNCTION 'GUI_DOWNLOAD'
  EXPORTING
    filename = 'C:\Users\erisom.almeida\Downloads\file.txt'
    filetype = 'ASC'
  TABLES
    data_tab = lt_final.
