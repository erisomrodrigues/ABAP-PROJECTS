*&---------------------------------------------------------------------*
*& Report ZPROG_ALV_BLOCK_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_alv_block_eri.


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

DATA: lt_vbak TYPE TABLE OF lty_vbak,
      lt_vbap TYPE TABLE OF lty_vbap.

DATA: lt_fieldcat_vbak TYPE slis_t_fieldcat_alv,
      lt_fieldcat_vbap TYPE slis_t_fieldcat_alv,
      lt_events_vbak   TYPE slis_t_event,
      lt_events_vbap   TYPE slis_t_event.

DATA: ls_vbak          TYPE lty_vbak,
      ls_vbap          TYPE lty_vbap,
      ls_fieldcat_vbak TYPE slis_fieldcat_alv,
      ls_fieldcat_vbap TYPE slis_fieldcat_alv,
      ls_layout_vbak   TYPE slis_layout_alv,
      ls_layout_vbap   TYPE slis_layout_alv.

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
ENDIF.

ls_fieldcat_VBAK-col_pos = '1'.
ls_fieldcat_VBAK-fieldname = 'VBELN'.
ls_fieldcat_VBAK-tabname = 'LT_VBAK'.
ls_fieldcat_VBAK-seltext_l = TEXT-000.
APPEND ls_fieldcat_VBAK TO lt_fieldcat_VBAK.
CLEAR ls_fieldcat_VBAK.

ls_fieldcat_VBAK-col_pos = '2'.
ls_fieldcat_VBAK-fieldname = 'ERDAT'.
ls_fieldcat_VBAK-tabname = 'LT_VBAK'.
ls_fieldcat_VBAK-seltext_l = TEXT-001.
APPEND ls_fieldcat_VBAK TO lt_fieldcat_VBAK.
CLEAR ls_fieldcat_VBAK.

ls_fieldcat_VBAK-col_pos = '3'.
ls_fieldcat_VBAK-fieldname = 'ERZET'.
ls_fieldcat_VBAK-tabname = 'LT_VBAK'.
ls_fieldcat_VBAK-seltext_l = TEXT-002.
APPEND ls_fieldcat_VBAK TO lt_fieldcat_VBAK.
CLEAR ls_fieldcat_VBAK.

ls_fieldcat_VBAK-col_pos = '4'.
ls_fieldcat_VBAK-fieldname = 'ERNAM'.
ls_fieldcat_VBAK-tabname = 'LT_VBAK'.
ls_fieldcat_VBAK-seltext_l = TEXT-003.
APPEND ls_fieldcat_VBAK TO lt_fieldcat_vbak.
CLEAR ls_fieldcat_VBAK.

ls_fieldcat_VBAK-col_pos = '5'.
ls_fieldcat_VBAK-fieldname = 'VBTYP'.
ls_fieldcat_VBAK-tabname = 'LT_VBAK'.
ls_fieldcat_VBAK-seltext_l = TEXT-004.
APPEND ls_fieldcat_VBAK TO lt_fieldcat_VBAK.
CLEAR ls_fieldcat_VBAK.

ls_fieldcat_VBAP-col_pos = '1'.
ls_fieldcat_VBAP-fieldname = 'VBELN'.
ls_fieldcat_VBAP-tabname = 'LT_VBAP'.
ls_fieldcat_VBAP-seltext_l = TEXT-000.
APPEND ls_fieldcat_VBAP TO lt_fieldcat_VBAP.
CLEAR ls_fieldcat_VBAP.

ls_fieldcat_VBAP-col_pos = '2'.
ls_fieldcat_VBAP-fieldname = 'POSNR'.
ls_fieldcat_VBAP-tabname = 'LT_VBAP'.
ls_fieldcat_VBAP-seltext_l = TEXT-005.
APPEND ls_fieldcat_VBAP TO lt_fieldcat_VBAP.
CLEAR ls_fieldcat_VBAP.

ls_fieldcat_VBAP-col_pos = '3'.
ls_fieldcat_VBAP-fieldname = 'MATNR'.
ls_fieldcat_VBAP-tabname = 'LT_VBAP'.
ls_fieldcat_VBAP-seltext_l = TEXT-006.
APPEND ls_fieldcat_vbap TO lt_fieldcat_vbap.
CLEAR ls_fieldcat_vbap.

CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_INIT'
  EXPORTING
    i_callback_program = sy-repid
*   I_CALLBACK_PF_STATUS_SET       = ' '
*   I_CALLBACK_USER_COMMAND        = ' '
*   IT_EXCLUDING       =
  .

CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
  EXPORTING
    is_layout                  = ls_layout_vbak
    it_fieldcat                = lt_fieldcat_vbak
    i_tabname                  = 'LT_VBAK'
    it_events                  = lt_events_vbak
*   IT_SORT                    =
*   I_TEXT                     = ' '
  TABLES
    t_outtab                   = lt_vbak
  EXCEPTIONS
    program_error              = 1
    maximum_of_appends_reached = 2
    OTHERS                     = 3.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
  EXPORTING
    is_layout                  = ls_layout_vbap
    it_fieldcat                = lt_fieldcat_vbap
    i_tabname                  = 'LT_VBAP'
    it_events                  = lt_events_vbaP
*   IT_SORT                    =
*   I_TEXT                     = ' '
  TABLES
    t_outtab                   = lt_vbap
  EXCEPTIONS
    program_error              = 1
    maximum_of_appends_reached = 2
    OTHERS                     = 3.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_DISPLAY'
* EXPORTING
*   I_INTERFACE_CHECK             = ' '
*   IS_PRINT                      =
*   I_SCREEN_START_COLUMN         = 0
*   I_SCREEN_START_LINE           = 0
*   I_SCREEN_END_COLUMN           = 0
*   I_SCREEN_END_LINE             = 0
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER       =
*   ES_EXIT_CAUSED_BY_USER        =
* EXCEPTIONS
*   PROGRAM_ERROR                 = 1
*   OTHERS                        = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
