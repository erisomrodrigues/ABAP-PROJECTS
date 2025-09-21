*&---------------------------------------------------------------------*
*& Report ZPRG_ALV_OOP_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg005_alv_oop_eri.

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
       END OF lty_vbap,

       BEGIN OF lty_final,
         vbeln TYPE vbeln_VA,
         erdat TYPE erdat,
         erzet TYPE erzet,
         ernam TYPE ernam,
         vbtyp TYPE vbtyp,
         posnr TYPE posnr_VA,
         matnr TYPE matnr,
       END OF lty_final.

DATA: lt_vbap  TYPE TABLE OF lty_vbap,
      lt_vbak  TYPE TABLE OF lty_vbak,
      lt_final TYPE TABLE OF lty_final.

DATA: lt_fieldcat TYPE lvc_t_fcat,
      lt_sort     TYPE lvc_t_sort,
      lt_filter   TYPE lvc_t_filt.

DATA: ls_vbap     TYPE lty_vbap,
      ls_vbak     TYPE lty_vbak,
      ls_final    TYPE lty_final,
      ls_fieldcat TYPE lvc_s_fcat,
      ls_sort     TYPE lvc_s_sort,
      ls_filter   TYPE lvc_s_filt.

DATA: lo_container TYPE REF TO cl_gui_custom_container,
      lo_grid      TYPE REF TO cl_gui_alv_grid.

SELECT-OPTIONS: S_vbeln FOR vbak-vbeln.

SELECT vbeln,
       erdat,
       erzet,
       ernam,
       vbtyp
  FROM vbak
  INTO TABLE @lt_vbak
  WHERE vbeln IN @s_vbeln.
IF lt_vbak IS NOT INITIAL.
  SELECT vbeln,
         posnr,
         matnr
    FROM vbap
    INTO TABLE @lt_vbap
     FOR ALL ENTRIES IN @lt_vbak
   WHERE vbeln EQ @lt_vbak-vbeln.
  IF lt_vbap IS NOT INITIAL.
    LOOP AT lt_vbak INTO ls_vbak.
      LOOP AT lt_vbap INTO ls_vbap WHERE vbeln = ls_vbak-vbeln.
        ls_final-vbeln = ls_vbap-vbeln.
        ls_final-erdat = ls_vbak-erdat.
        ls_final-erzet = ls_vbak-erzet.
        ls_final-ernam = ls_vbak-ernam.
        ls_final-vbtyp = ls_vbak-vbtyp.
        ls_final-posnr = ls_vbap-posnr.
        ls_final-matnr = ls_vbap-matnr.
        APPEND ls_final TO lt_final.
      ENDLOOP.
    ENDLOOP.
  ENDIF.
ENDIF.

CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
  EXPORTING
*   I_BUFFER_ACTIVE        =
    i_structure_name       = 'ZSTR_ALV_FIELDCAT_ERI'
*   I_CLIENT_NEVER_DISPLAY = 'X'
*   I_BYPASSING_BUFFER     =
*   I_INTERNAL_TABNAME     =
  CHANGING
    ct_fieldcat            = lt_fieldcat
  EXCEPTIONS
    inconsistent_interface = 1
    program_error          = 2
    OTHERS                 = 3.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

CREATE OBJECT lo_container
  EXPORTING
    container_name = 'CONT'.

CREATE OBJECT lo_grid
  EXPORTING
    i_parent = lo_container.

ls_filter-fieldname = 'POSNR'.
ls_filter-sign      = 'I'.
ls_filter-option = 'EQ'.
ls_filter-low = '10'.
APPEND ls_filter TO lt_filter.

CALL METHOD lo_grid->set_table_for_first_display
  CHANGING
    it_outtab                     = lt_final
    it_fieldcatalog               = lt_fieldcat
*   it_sort                       = lt_sort
    it_filter                     = lt_filter
  EXCEPTIONS
    invalid_parameter_combination = 1
    program_error                 = 2
    too_many_lines                = 3
    OTHERS                        = 4.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

CALL SCREEN '100'.

INCLUDE zprg005_alv_oop_eri_i01.

INCLUDE zprg005_alv_oop_eri_o01.

*----------------------------------------------------------------------*
***INCLUDE ZPRG_ALV_OOP_ERI_USER_COMMAI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  IF sy-ucomm = 'BACK'.
    LEAVE TO SCREEN 0.
  ENDIF.
ENDMODULE.

*----------------------------------------------------------------------*
***INCLUDE ZPRG_ALV_OOP_ERI_STATUS_010O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'ORDER'.
 SET TITLEBAR 'ORD'.
ENDMODULE.
