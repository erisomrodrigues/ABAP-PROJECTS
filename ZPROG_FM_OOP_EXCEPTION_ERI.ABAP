FUNCTION zfm_oop_exception_eri.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IM_MATNR) TYPE  MAKT-MATNR
*"     REFERENCE(IM_SPRAS) TYPE  MAKT-SPRAS
*"  EXPORTING
*"     REFERENCE(EX_MAKTX) TYPE  MAKT-MAKTX
*"  EXCEPTIONS
*"      INVALID_MATERIAL
*"----------------------------------------------------------------------
  SELECT SINGLE maktx
    FROM makt
    INTO ex_maktx
   WHERE matnr EQ im_matnr
     AND spras EQ im_spras.
  IF sy-subrc IS NOT INITIAL.
    RAISE invalid_material.
  ENDIF.

ENDFUNCTION.

*&---------------------------------------------------------------------*
*& Report ZPROG_FM_OOP_EXCEPTION_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_fm_oop_exception_eri.

DATA v_matnr TYPE makt-matnr VALUE '1234567890'.
DATA v_maktx TYPE makt-maktx.

CALL FUNCTION 'ZFM_OOP_EXCEPTION_ERI'
  EXPORTING
    im_matnr         = v_matnr
    im_spras         = sy-langu
  IMPORTING
    ex_maktx         = v_maktx
  EXCEPTIONS
    invalid_material = 1
    OTHERS           = 2.
IF sy-subrc <> 0.
  WRITE:/ 'Implement suitable error handling here'.
ENDIF.
