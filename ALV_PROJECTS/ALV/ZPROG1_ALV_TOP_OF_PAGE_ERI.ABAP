*&---------------------------------------------------------------------*
*& Report ZPROG_ALV_DISPLAY_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog1_alv_top_of_page_eri.

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
      lt_list     TYPE slis_t_listheader.

DATA: ls_vbak     TYPE lty_vbak,
      ls_vbap     TYPE lty_vbap,
      lS_final    TYPE zstr_alv_eri,
      ls_fieldcat TYPE slis_fieldcat_alv,
      ls_list     TYPE slis_listheader.

DATA: lv_vbeln    TYPE vbeln_va,
      lv_input    TYPE string,
      lv_lines(5) TYPE c.

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

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK      = ' '
*     I_BYPASSING_BUFFER     = ' '
*     I_BUFFER_ACTIVE        = ' '
      i_callback_program     = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     i_callback_user_command = ' '
      i_callback_top_of_page = 'TOP_PAGE'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME       =
*     I_BACKGROUND_ID        = ' '
*     I_GRID_TITLE           =
*     I_GRID_SETTINGS        =
*     IS_LAYOUT              =
      it_fieldcat            = lt_fieldcat
*     IT_EXCLUDING           =
*     IT_SPECIAL_GROUPS      =
*     IT_SORT                =
*     IT_FILTER              =
*     IS_SEL_HIDE            =
*     I_DEFAULT              = 'X'
*     I_SAVE                 = ' '
*     IS_VARIANT             =
*     IT_EVENTS              =
*     IT_EVENT_EXIT          =
*     IS_PRINT               =
*     IS_REPREP_ID           =
*     I_SCREEN_START_COLUMN  = 0
*     I_SCREEN_START_LINE    = 0
*     I_SCREEN_END_COLUMN    = 0
*     I_SCREEN_END_LINE      = 0
*     I_HTML_HEIGHT_TOP      = 0
*     I_HTML_HEIGHT_END      = 0
*     IT_ALV_GRAPHICS        =
*     IT_HYPERLINK           =
*     IT_ADD_FIELDCAT        =
*     IT_EXCEPT_QINFO        =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*     O_PREVIOUS_SRAL_HANDLER =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER =
*     ES_EXIT_CAUSED_BY_USER =
    TABLES
      t_outtab               = lt_final
    EXCEPTIONS
      program_error          = 1
      OTHERS                 = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDIF.

FORM top_page.
  ls_list-typ = 'H'.
  ls_list-info = 'Exibição de Ordem de Vendas'.
  APPEND ls_list TO lt_list.
  CLEAR ls_list.

  CONCATENATE s_vbeln-low 'TO' s_vbeln-high INTO lv_input SEPARATED BY space.

  ls_list-typ = 'S'.
  ls_list-key = 'Valores inseridos'.
  ls_list-info = lv_input.
  APPEND ls_list TO lt_list.
  CLEAR ls_list.

  DESCRIBE TABLE lt_finaL LINES lv_lines.
  CONCATENATE 'Número de linha ' lv_lines INTO lv_input SEPARATED BY space.

  ls_list-typ = 'A'.
  ls_LIST-info = lv_input.
  APPEND ls_list TO lt_list.
  CLEAR ls_list.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_list.
ENDFORM.
