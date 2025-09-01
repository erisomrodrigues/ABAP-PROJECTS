*&---------------------------------------------------------------------*
*& Report ZPROG_ALV_DISPLAY_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_alv_display_eri.

TYPES: BEGIN OF lty_vbak,
         vbeln TYPE vbeln_va,
         erdat TYPE erdat,
         erzet TYPE erzet,
         ernam TYPE ernam,
         vbtyp TYPE vbtypl,
       END OF lty_vbak,

       BEGIN OF lty_vbap,
         vbeln TYPE vbeln_va,
         posnr TYPE posnr_va,
         matnr TYPE matnr,
       END OF lty_vbap.

DATA: lt_vbak  TYPE TABLE OF lty_vbak,
      lt_vbap  TYPE TABLE OF lty_vbap,
      lt_final TYPE TABLE OF zstr_alv_eri.

DATA lt_fieldcat TYPE slis_t_fieldcat_alv.

DATA: ls_vbak  TYPE lty_vbak,
      ls_vbap  TYPE lty_vbap,
      lS_final TYPE zstr_alv_eri.

DATA  lv_vbeln TYPE vbeln_va.

SELECT-OPTIONS: s_vbeln FOR lv_vbeln.

SELECT vbeln erdat erzet ernam vbtyp
  FROM vbak
  INTO TABLE lt_vbak
 WHERE vbeln IN s_vbeln.
IF lt_vbak IS NOT INITIAL.

  SELECT vbeln posnr matnr
    FROM vbap
    INTO TABLE lt_vbap
     FOR ALL ENTRIES IN lt_vbak
   WHERE vbeln EQ lt_vbak-vbeln.

  LOOP AT lt_vbak INTO ls_vbak.
    LOOP AT lt_vbap INTO ls_vbap WHERE vbeln = ls_vbak-vbeln.
      ls_final-vbeln = ls_vbap-vbeln.
      ls_final-erdat = ls_vbak-erdat.
      ls_final-erzet = ls_vbak-erzet.
      ls_final-ernam = ls_vbak-ernam.
      ls_final-vbtyp = ls_vbaK-vbtyp.
      ls_final-posnr = ls_vbap-posnr.
      ls_final-matnr = ls_vbap-matnr.
      APPEND ls_final TO lt_final.
    ENDLOOP.
  ENDLOOP.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZSTR_ALV_ERI'
    CHANGING
      ct_fieldcat            = lt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
    EXPORTING
      it_fieldcat = lt_fieldcat
    TABLES
      t_outtab    = lt_final.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDIF.
