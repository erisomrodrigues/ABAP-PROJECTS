*&---------------------------------------------------------------------*
*& Report ZPROG_LOOP_REVERSE_STEP_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_loop_reverse_step_eri.

SELECT ebeln
  FROM ekko
  INTO TABLE @DATA(lt_ekko)
  UP TO 10 ROWS.

WRITE '***** NORMAL LOOPING *****' COLOR 1.

LOOP AT lt_ekko INTO DATA(ls_ekko).
  WRITE:/ ls_ekko-ebeln COLOR 1.
ENDLOOP.

ULINE.

WRITE / '***** REVERSE LOOPING' COLOR 7.

LOOP AT lt_ekko INTO ls_ekko STEP -1.
  WRITE: / ls_ekko-ebeln COLOR 7.
ENDLOOP.
