*&---------------------------------------------------------------------*
*& Report ZPROG_CREATE_INSTANCE_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_methods_eri.

CLASS lcl_loucutor DEFINITION.
  PUBLIC SECTION.
    DATA: nome            TYPE string,
          idade           TYPE i,
          ultima_mensagem TYPE string.

*    CLASS-METHODS: "Methods funcionais (Quando contém parametros de returning)
*      _gerar_loucutor
*        IMPORTING
*          iv_nome          TYPE string
*          iv_idade         TYPE i OPTIONAL
*        EXPORTING
*          eo_loucutor      TYPE REF TO lcl_loucutor
*        RETURNING
*          VALUE(instanica) TYPE REF TO lcl_loucutor.

    METHODS:
      constructor
        IMPORTING
          iv_nome  TYPE string
          iv_idade TYPE i OPTIONAL,

      falar
        IMPORTING
          iv_mensagem TYPE string OPTIONAL
          it_mensagem TYPE string_table OPTIONAL
            PREFERRED PARAMETER iv_mensagem, "Determina a preferência a IV_mensagem. Pois, é mais constante

      possui_idade
        RETURNING
          VALUE(return) TYPE boolean.
*        EXPORTING
*          Return TYPE boolean.
ENDCLASS.

START-OF-SELECTION.

  "Modo antigo
  DATA: lo_loucutor1 TYPE REF TO lcl_loucutor.
  DATA: lo_loucutor2 TYPE REF TO lcl_loucutor.
*  CREATE OBJECT lo_loucutor.

  "ABAP 7.4
*  DATA(lo_loucutor) = NEW lcl_loucutor( ).

  "Quando os parametros do methods não são OPTIONAL podem ser instânciado dessa forma
*  CREATE OBJECT lo_loucutor1
*    EXPORTING
*      iv_nome  = 'Max'
*      iv_idade = 23.
*
*  CREATE OBJECT lo_loucutor2
*    EXPORTING
*      iv_nome = 'José'.


*  lo_loucutor1->falar( iv_mensagem = 'Quero café!' ).
*  lo_loucutor2->falar( iv_mensagem = 'Quero ir para casa!' ).
*
*  IF lo_loucutor1->possui_idade( ) = abap_true.
*    WRITE:/ 'Sim, possui idade'.
*  ELSE.
*    WRITE:/ 'Não, não possui idade'.
*  ENDIF.
*
*  IF lo_loucutor2->possui_idade( ) = abap_true.
*    WRITE:/ 'Sim, possui idade'.
*  ELSE.
*    WRITE:/ 'Não, não possui idade'.
*  ENDIF.
************* Quando usado o PREFERRED PARAMETER no method ******************
  CREATE OBJECT lo_loucutor1
    EXPORTING
      iv_nome  = 'Max'
      iv_idade = 23.

  lo_loucutor1->falar( 'Quero café!'
*    iv_mensagem =
*    it_mensagem =
  ).
*****************************************************************************
CLASS lcl_loucutor IMPLEMENTATION.
*  METHOD _gerar_loucutor.
*  ENDMETHOD.

  METHOD constructor.
    nome = iv_nome.
    idade = iv_idade.
  ENDMETHOD.

  METHOD falar.
    WRITE:/ 'O Loucutor', nome COLOR COL_TOTAL, 'diz', iv_mensagem COLOR COL_POSITIVE.
    ultima_mensagem = iv_mensagem.
  ENDMETHOD.

  METHOD possui_idade.
  ENDMETHOD.
ENDCLASS.
