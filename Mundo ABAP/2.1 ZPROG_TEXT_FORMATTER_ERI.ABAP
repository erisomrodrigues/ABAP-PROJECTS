*&---------------------------------------------------------------------*
*& Report ZPROG_TEXT_FORMATTER_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPROG_TEXT_FORMATTER_ERI.

START-OF-SELECTION.

perform classe_utilitaria.

FORM classe_utilitaria.
  WRITE:/ zcl_text_formatter_eri=>cpf( id_cpf = '06104627331' ).
  WRITE:/ zcl_text_formatter_eri=>cnpj( id_cnpj = '07965809000165' ).
  WRITE:/ zcl_text_formatter_eri=>telefone( id_telefone = '85997987954' ).
ENDFORM.
