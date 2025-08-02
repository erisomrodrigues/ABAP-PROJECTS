*&---------------------------------------------------------------------*
*& Report ZPROG_VISIBILIDADE_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_encapsulamento_visib_eri.

CLASS lcl_pessoa DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_nome TYPE string,

      perguntar_nome
        IMPORTING
          io_pessoa TYPE REF TO lcl_pessoa,

      responder_nome.

  PRIVATE SECTION.
    DATA:
      nome TYPE string.

    METHODS:
      falar
        IMPORTING
          iv_frase TYPE string.

ENDCLASS.

START-OF-SELECTION.
  DATA: lo_pessoa_erisom  TYPE REF TO lcl_pessoa,
        lo_pessoa_mariane TYPE REF TO lcl_pessoa.

  CREATE OBJECT lo_pessoa_erisom
    EXPORTING
      iv_nome = 'Erisom'.

  CREATE OBJECT lo_pessoa_mariane
    EXPORTING
      iv_nome = 'Mariane'.

  lo_pessoa_erisom->perguntar_nome( lo_pessoa_mariane ).
  SKIP.
  lo_pessoa_mariane->perguntar_nome( lo_pessoa_erisom ).

CLASS lcl_pessoa IMPLEMENTATION.
  METHOD constructor.
    me->nome = iv_nome.
  ENDMETHOD.

  METHOD perguntar_nome.
    me->falar( 'Qual o seu nome?'  ).
    io_pessoa->responder_nome( ).
  ENDMETHOD.

  METHOD responder_nome.
    me->falar( | Meu nome é { me->nome }|  ).
  ENDMETHOD.

  METHOD falar.
    WRITE:/ iv_frase.
  ENDMETHOD.

ENDCLASS.
