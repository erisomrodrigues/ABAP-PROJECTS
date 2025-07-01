*&---------------------------------------------------------------------*
*& Report ZPROG_CLASSES_FRIENDS_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_classes_friends_eri.

START-OF-SELECTION.

  DATA lo_ana TYPE REF TO zcl_ana_eri.
  DATA lo_maria TYPE REF TO zcl_maria_eri.

  LO_ana = NEW zcl_ana_eri( ).
  LO_Maria = NEW zcl_maria_eri( ).

  lo_ana->situacao_financeira( ).
  lo_maria->revelar_segredos( io_ana = lo_ana ).
  lo_maria->revelar_segredos( io_ana = lo_ana ).
