*&---------------------------------------------------------------------*
*& Report ZPRG001_ALV_OOP_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg008_alv_oop_eri.

TABLES: vbak.

TYPES: BEGIN OF lty_vbak,
         vbeln TYPE vbeln_va,
         erdat TYPE erdat,
         erzet TYPE erzet,
         ernam TYPE ernam,
         vbtyp TYPE vbtyp,
       END OF lty_vbak,

       BEGIN OF lty_vbap,
         vbeln TYPE vbeln_va,
         posnr TYPE posnr_va,
         matnr TYPE matnr,
       END OF lty_vbap.


DATA: lt_vbap TYPE TABLE OF lty_vbap,
      lt_vbak TYPE TABLE OF lty_vbak.

DATA: lt_fieldcat1 TYPE lvc_t_fcat,
      lt_fieldcat2 TYPE lvc_t_fcat,
      lt_rows      TYPE lvc_t_row.

DATA: ls_vbap      TYPE lty_vbap,
      ls_vbak      TYPE lty_vbak,
      ls_fieldcat1 TYPE lvc_s_fcat,
      ls_fieldcat2 TYPE lvc_s_fcat,
      ls_rows      TYPE lvc_s_row.

DATA: lo_cont1 TYPE REF TO cl_gui_custom_container,
      lo_cont2 TYPE REF TO cl_gui_custom_container,
      lo_alv1  TYPE REF TO cl_gui_alv_grid,
      lo_alv2  TYPE REF TO cl_gui_alv_grid.

SELECT-OPTIONS: S_vbeln FOR vbak-vbeln.

CLASS class1 DEFINITION.
  PUBLIC SECTION.
    METHODS handle FOR EVENT double_click OF cl_gui_alv_grid.
ENDCLASS.

CLASS class1 IMPLEMENTATION.
  METHOD handle.
    CALL METHOD lo_alv1->get_selected_rows
      IMPORTING
        et_index_rows = lt_rows.

    READ TABLE lt_rows INTO ls_rows INDEX  1.
    IF sy-subrc IS INITIAL.
      READ TABLE lt_vbak INTO ls_vbak INDEX ls_rows-index.
      IF sy-subrc IS INITIAL.
        SELECT vbeln posnr matnr
          FROM vbap
          INTO TABLE lt_vbap
         WHERE vbeln = ls_vbak-vbeln.

        CALL METHOD lo_alv2->set_table_for_first_display
          CHANGING
            it_outtab                     = lt_vbap
            it_fieldcatalog               = lt_fieldcat2
          EXCEPTIONS
            invalid_parameter_combination = 1
            program_error                 = 2
            too_many_lines                = 3
            OTHERS                        = 4.
        IF sy-subrc <> 0.
*             Implement suitable error handling here
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  SELECT vbeln,
         erdat,
         erzet,
         ernam,
         vbtyp
    FROM vbak
    INTO TABLE @lt_vbak
    WHERE vbeln IN @s_vbeln.

  ls_fieldcat1-col_pos = '1'.
  ls_fieldcat1-fieldname = 'VBELN'.
  ls_fieldcat1-tabname = 'LT_VBAK'.
  ls_fieldcat1-scrtext_l = 'Sales Ordem'.
  APPEND ls_fieldcat1 TO lt_fieldcat1.
  CLEAR ls_fieldcat1.

  ls_fieldcat1-col_pos = '2'.
  ls_fieldcat1-fieldname = 'ERDAT'.
  ls_fieldcat1-tabname = 'LT_VBAK'.
  ls_fieldcat1-scrtext_l = 'Date Ordem'.
  APPEND ls_fieldcat1 TO lt_fieldcat1.
  CLEAR ls_fieldcat1.

  ls_fieldcat1-col_pos = '3'.
  ls_fieldcat1-fieldname = 'ERZET'.
  ls_fieldcat1-tabname = 'LT_VBAK'.
  ls_fieldcat1-scrtext_l = 'Hora Registro'.
  APPEND ls_fieldcat1 TO lt_fieldcat1.
  CLEAR ls_fieldcat1.

  ls_fieldcat1-col_pos = '4'.
  ls_fieldcat1-fieldname = 'ERNAM'.
  ls_fieldcat1-tabname = 'LT_VBAK'.
  ls_fieldcat1-scrtext_l = 'Nome Usúario'.
  APPEND ls_fieldcat1 TO lt_fieldcat1.
  CLEAR ls_fieldcat1.

  ls_fieldcat1-col_pos = '5'.
  ls_fieldcat1-fieldname = 'VBTYP'.
  ls_fieldcat1-tabname = 'LT_VBAK'.
  ls_fieldcat1-scrtext_l = 'Tipo'.
  APPEND ls_fieldcat1 TO lt_fieldcat1.
  CLEAR ls_fieldcat1.

  CREATE OBJECT lo_cont1
    EXPORTING
      container_name = 'CONT1'.

  CREATE OBJECT lo_alv1
    EXPORTING
      i_parent = lo_cont1.

  CALL METHOD lo_alv1->set_table_for_first_display
    CHANGING
      it_outtab                     = lt_vbak
      it_fieldcatalog               = lt_fieldcat1
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  ls_fieldcat2-col_pos = '1'.
  ls_fieldcat2-fieldname = 'VBELN'.
  ls_fieldcat2-tabname = 'LT_VBAK'.
  ls_fieldcat2-scrtext_l = 'Sales Ordem'.
  APPEND ls_fieldcat2 TO lt_fieldcat2.
  CLEAR ls_fieldcat2.

  ls_fieldcat2-col_pos = '2'.
  ls_fieldcat2-fieldname = 'POSNR'.
  ls_fieldcat2-tabname = 'LT_VBAK'.
  ls_fieldcat2-scrtext_l = 'Item'.
  APPEND ls_fieldcat2 TO lt_fieldcat2.
  CLEAR ls_fieldcat2.

  ls_fieldcat2-col_pos = '3'.
  ls_fieldcat2-fieldname = 'MATNR'.
  ls_fieldcat2-tabname = 'LT_VBAK'.
  ls_fieldcat2-scrtext_l = 'Material'.
  APPEND ls_fieldcat2 TO lt_fieldcat2.
  CLEAR ls_fieldcat2.

  CREATE OBJECT lo_cont2
    EXPORTING
      container_name = 'CONT2'.

  CREATE OBJECT lo_alv2
    EXPORTING
      i_parent = lo_cont2.

  CALL METHOD lo_alv2->set_table_for_first_display
    CHANGING
      it_outtab                     = lt_vbap
      it_fieldcatalog               = lt_fieldcat2
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.
  IF sy-subrc <> 0.
*             Implement suitable error handling here
  ENDIF.

  DATA: lo_object TYPE REF TO class1.
  CREATE OBJECT lo_object.
  SET HANDLER lo_object->handle FOR lo_alv1.


  CALL SCREEN '100'.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'ORDER'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  IF sy-ucomm EQ 'CANCEL'.
    LEAVE TO SCREEN 0.
  ENDIF.

ENDMODULE.
