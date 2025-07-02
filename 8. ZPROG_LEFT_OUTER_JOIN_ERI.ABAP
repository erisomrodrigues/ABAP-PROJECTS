*&---------------------------------------------------------------------*
*& Report ZPROG_LEFT_OUTER_JOIN_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_left_outer_join_eri.

SELECT *
  FROM mara
    UP TO 100 ROWS
  INTO TABLE @DATA(lt_mara).

SELECT *
  FROM mard
    UP TO 100 ROWS
  INTO TABLE @DATA(lt_mard)
   FOR ALL ENTRIES IN @lt_mara
 WHERE matnr EQ @lt_mara-matnr.

SELECT *
  FROM marc
    UP TO 100 ROWS
  INTO TABLE @DATA(lt_marc)
   FOR ALL ENTRIES IN @lt_mara
 WHERE matnr EQ @lt_mara-matnr.

SELECT FROM @lt_mara AS a
  LEFT OUTER JOIN @lt_MARC AS b
    ON a~matnr EQ b~matnr
  LEFT OUTER JOIN @lt_mard AS c
    ON c~matnr EQ b~matnr
   AND c~werks EQ b~werks
FIELDS c~lgort, b~werks, a~*
  INTO TABLE @DATA(lt_output).
IF sy-subrc IS INITIAL.
  cl_demo_output=>display( lt_output ).
ENDIF.
