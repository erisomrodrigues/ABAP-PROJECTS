*&---------------------------------------------------------------------*
*& Report ZPROG_ALV_HIERSEQ_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_alv_hierseq_eri.

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

DATA lv_vbeln TYPE vbeln_va.

DATA: lt_vbak TYPE TABLE OF lty_vbak,
      lt_vbap TYPE TABLE OF lty_vbap.

DATA lt_fieldcat TYPE slis_t_fieldcat_alv.

DATA: ls_vbak     TYPE lty_vbak,
      ls_vbap     TYPE lty_vbap,
      ls_fieldcat TYPE slis_fieldcat_alv,
      ls_keyinfo  TYPE slis_keyinfo_alv.

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
ENDIF.

ls_fieldcat-col_pos   = '1'.
ls_fieldcat-fieldname = 'VBELN'.
ls_fieldcat-tabname   = 'LT_VBAK'.
ls_fieldcat-seltext_l = 'Documento de Vendas'.
APPEND ls_fieldcat TO lt_fieldcat.
CLEAR ls_fieldcat.

ls_fieldcat-col_pos   = '2 '.
ls_fieldcat-fieldname = 'POSNR'.
ls_fieldcat-tabname   = 'LT_VBAP'.
ls_fieldcat-seltext_l = 'Item do Documento'.
APPEND ls_fieldcat TO lt_fieldcat.
CLEAR ls_fieldcat.

ls_fieldcat-col_pos   = '3'.
ls_fieldcat-fieldname = 'MATNR'.
ls_fieldcat-tabname   = 'LT_VBAP'.
ls_fieldcat-seltext_l = 'Nº do Item'.
APPEND ls_fieldcat TO lt_fieldcat.
CLEAR ls_fieldcat.

ls_fieldcat-col_pos   = '4'.
ls_fieldcat-fieldname = 'ERNAM'.
ls_fieldcat-tabname   = 'LT_VBAK'.
ls_fieldcat-seltext_l = 'Usuario de Criação'.
APPEND ls_fieldcat TO lt_fieldcat.
CLEAR ls_fieldcat.

ls_fieldcat-col_pos   = '5'.
ls_fieldcat-fieldname = 'VBTYP'.
ls_fieldcat-tabname   = 'LT_VBAK'.
ls_fieldcat-seltext_l = 'Categoria de Documento'.
APPEND ls_fieldcat TO lt_fieldcat.
CLEAR ls_fieldcat.



ls_keyinfo-header01 = 'VBELN'.
ls_keyinfo-item01   = 'VBELN'.

CALL FUNCTION 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
  EXPORTING
*   I_INTERFACE_CHECK              = ' '
*   I_CALLBACK_PROGRAM             =
*   I_CALLBACK_PF_STATUS_SET       = ' '
*   I_CALLBACK_USER_COMMAND        = ' '
*   IS_LAYOUT        =
    it_fieldcat      = lt_fieldcat
*   IT_EXCLUDING     =
*   IT_SPECIAL_GROUPS              =
*   IT_SORT          =
*   IT_FILTER        =
*   IS_SEL_HIDE      =
*   I_SCREEN_START_COLUMN          = 0
*   I_SCREEN_START_LINE            = 0
*   I_SCREEN_END_COLUMN            = 0
*   I_SCREEN_END_LINE              = 0
*   I_DEFAULT        = 'X'
*   I_SAVE           = ' '
*   IS_VARIANT       =
*   IT_EVENTS        =
*   IT_EVENT_EXIT    =
    i_tabname_header = 'LT_VBAK'
    i_tabname_item   = 'LT_VBAP'
*   I_STRUCTURE_NAME_HEADER        =
*   I_STRUCTURE_NAME_ITEM          =
    is_keyinfo       = ls_keyinfo
*   IS_PRINT         =
*   IS_REPREP_ID     =
*   I_BYPASSING_BUFFER             =
*   I_BUFFER_ACTIVE  =
*   IR_SALV_HIERSEQ_ADAPTER        =
*   IT_EXCEPT_QINFO  =
*   I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE
*   I_LIST_DISPLAY_ONLY            = ABAP_FALSE
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER        =
*   ES_EXIT_CAUSED_BY_USER         =
  TABLES
    t_outtab_header  = lt_vbak
    t_outtab_item    = lt_vbap
  EXCEPTIONS
    program_error    = 1
    OTHERS           = 2.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
