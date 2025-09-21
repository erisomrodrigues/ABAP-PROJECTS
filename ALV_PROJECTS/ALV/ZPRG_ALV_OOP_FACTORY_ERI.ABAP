*&---------------------------------------------------------------------*
*& Report ZPRG_ALV_OOP_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_alv_oop_factory_eri.

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

DATA: ls_vbap  TYPE lty_vbap,
      ls_vbak  TYPE lty_vbak,
      ls_final TYPE lty_final.

DATA: lo_alv TYPE REF TO cl_salv_table.

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

TRY.
    CALL METHOD cl_salv_table=>factory
*  EXPORTING
*    list_display   = IF_SALV_C_BOOL_SAP=>FALSE
*    r_container    =
*    container_name =
      IMPORTING
        r_salv_table = lo_alv
      CHANGING
        t_table      = lt_final.
  CATCH cx_salv_msg.
ENDTRY.

CALL METHOD lo_alv->if_salv_gui_om_table_action~display.
