*&---------------------------------------------------------------------*
*& Report ZPROG_ALV_DISPLAY_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_alv_fieldcatalog_mer_eri.

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

DATA: ls_vbak     TYPE lty_vbak,
      ls_vbap     TYPE lty_vbap,
      lS_final    TYPE zstr_alv_eri,
      ls_fieldcat TYPE slis_fieldcat_alv.

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

  "1) - Utilizando um catalogo de campos pré definido
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZSTR_ALV_ERI' "Estrututra criado no diciionario de dados SE11
    CHANGING
      ct_fieldcat            = lt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  "2) - Modificando o catalogo de campos do modulo de função
  LOOP AT lt_fieldcat INTO ls_fieldcat.
    IF ls_fieldcat-fieldname = 'VBELN'.
      ls_fieldcat-seltext_l = 'Nº do Documento de Vendas'.
      MODIFY lt_fieldcat FROM ls_fieldcat TRANSPORTING seltext_l.
    ENDIF.
    IF ls_fieldcat-fieldname = 'ERDAT'.
      ls_fieldcat-seltext_l = 'Data de Criação do Documento'.
      MODIFY lt_fieldcat FROM ls_fieldcat TRANSPORTING seltext_l.
    ENDIF.
    IF ls_fieldcat-fieldname =  'ERZET'.
      ls_fieldcat-seltext_l = 'Hora de Criação do Documento'.
      MODIFY lt_fieldcat FROM ls_fieldcat TRANSPORTING seltext_l.
    ENDIF.
  ENDLOOP.

  "2) - Modelo mais robusto
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      it_fieldcat   = lt_fieldcat
    TABLES
      t_outtab      = lt_final
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDIF.
