class ZCL_TEXT_FORMATTER_ERI definition
  public
  final
  create public .

public section.

  class-methods CPF
    importing
      value(ID_CPF) type CHAR11
    returning
      value(RD_CPF) type CHAR14 .
  class-methods CNPJ
    importing
      value(ID_CNPJ) type CHAR20
    returning
      value(RD_CNPJ) type CHAR20 .
  class-methods TELEFONE
    importing
      value(ID_TELEFONE) type CHAR20
    returning
      value(RD_TELEFONE) type CHAR20 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_TEXT_FORMATTER_ERI IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_TEXT_FORMATTER_ERI=>CNPJ
* +-------------------------------------------------------------------------------------------------+
* | [--->] ID_CNPJ                        TYPE        CHAR20
* | [<-()] RD_CNPJ                        TYPE        CHAR20
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD cnpj.
    CONCATENATE id_cnpj+0(2) '.' id_cnpj+2(3) '.' id_cnpj+8(3) '/' id_cnpj+11(4) '-' id_cnpj+13(2) INTO rd_cnpj.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_TEXT_FORMATTER_ERI=>CPF
* +-------------------------------------------------------------------------------------------------+
* | [--->] ID_CPF                         TYPE        CHAR11
* | [<-()] RD_CPF                         TYPE        CHAR14
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method CPF.
    CONCATENATE id_cpf+0(3) '.' id_cpf+3(3) '.' id_cpf+6(3) '-' ID_CPF+9(2) INTO rd_cpf.
  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_TEXT_FORMATTER_ERI=>TELEFONE
* +-------------------------------------------------------------------------------------------------+
* | [--->] ID_TELEFONE                    TYPE        CHAR20
* | [<-()] RD_TELEFONE                    TYPE        CHAR20
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method TELEFONE.
    CONCATENATE '(' id_telefone+0(2) ')' id_telefone+2(1) ' ' id_telefone+3(4) '-' id_telefone+7(4)
     INTO rd_telefone RESPECTING BLANKS.
  endmethod.
ENDCLASS.
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
