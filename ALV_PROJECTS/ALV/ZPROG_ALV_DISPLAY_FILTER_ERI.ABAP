*&---------------------------------------------------------------------*
*& Report ZPROG_ALV_DISPLAY_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_alv_display_filter_eri.

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

DATA: lt_fieldcat TYPE slis_t_fieldcat_alv,
      lt_sort     TYPE slis_t_sortinfo_alv,
      lt_filter   TYPE slis_t_filter_alv.

DATA: ls_vbak     TYPE lty_vbak,
      ls_vbap     TYPE lty_vbap,
      lS_final    TYPE zstr_alv_eri,
      ls_fieldcat TYPE slis_fieldcat_alv,
      ls_sort     TYPE slis_sortinfo_alv,
      ls_filter   TYPE slis_filter_alv.

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

  "3) - Definindo o catalogo de campos manualmente
  ls_fieldcat-col_pos = '1'.
  ls_fieldcat-fieldname = 'VBELN'.
  ls_fieldcat-tabname = 'LT_FINAL'.
  ls_fieldcat-seltext_l = 'Documento de Vendas'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = '2'.
  ls_fieldcat-fieldname = 'ERDAT'.
  ls_fieldcat-tabname = 'LT_FINAL'.
  ls_fieldcat-seltext_l = 'Data de Criação'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = '3'.
  ls_fieldcat-fieldname = 'ERZET'.
  ls_fieldcat-tabname = 'LT_FINAL'.
  ls_fieldcat-seltext_l = 'Hora de Criação'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = '4'.
  ls_fieldcat-fieldname = 'ERNAM'.
  ls_fieldcat-tabname = 'LT_FINAL'.
  ls_fieldcat-seltext_l = 'Usuario de Criação'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = '5'.
  ls_fieldcat-fieldname = 'VBTYP'.
  ls_fieldcat-tabname = 'LT_FINAL'.
  ls_fieldcat-seltext_l = 'Categoria de Documento'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = '6'.
  ls_fieldcat-fieldname = 'POSNR'.
  ls_fieldcat-tabname = 'LT_FINAL'.
  ls_fieldcat-seltext_l = 'Item do Documento'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = '7'.
  ls_fieldcat-fieldname = 'MATNR'.
  ls_fieldcat-tabname = 'LT_FINAL'.
  ls_fieldcat-seltext_l = 'Nº do Item'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_sort-fieldname = 'ERDAT'.
  ls_sort-up        = 'X'.
  APPEND ls_sort TO lt_sort.

  ls_filter-fieldname = 'ERNAM'.
  ls_filter-tabname = 'LT_FINAL'.
  ls_filter-no_sign = 'I'.
  ls_filter-optio   = 'EQ'.
  ls_filter-valuf_int = 'MLARISSA2'.
  APPEND ls_filter TO lt_filter.

  "2) - Modelo mais robusto
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      it_fieldcat   = lt_fieldcat
      it_sort       = lt_sort
      it_filter     = lt_filter
    TABLES
      t_outtab      = lt_final
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDIF.
