*&---------------------------------------------------------------------*
*& Report ZPROG_OO_RELACOES_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_oo_relacoes_eri.

CLASS lcl_JOGADOR DEFINITION DEFERRED.
CLASS lcl_CHUTEIRA DEFINITION DEFERRED.
CLASS lcl_selecao DEFINITION DEFERRED.
CLASS lcl_CAMPO DEFINITION DEFERRED.


CLASS lcl_pessoa DEFINITION.
  PUBLIC SECTION.
    DATA: nome          TYPE string,
          idade         TYPE i,
          cor_racial    TYPE string,
          estilo_cabelo TYPE String.

    METHODS fala.
ENDCLASS.

CLASS lcl_tecnico DEFINITION INHERITING FROM lcl_pessoa.
  PUBLIC SECTION.
    DATA: selecao TYPE REF TO lcl_selecao.
ENDCLASS.

CLASS lcl_selecao DEFINITION.
  PUBLIC SECTION.
    DATA: jogadores TYPE TABLE OF REF TO lcl_jogador,
          tecnico   TYPE REF TO lcl_tecnico.
    METHODS:
      escalar_jogador
        IMPORTING
          jogador TYPE REF TO lcl_jogador.
ENDCLASS.

CLASS lcl_jogador DEFINITION INHERITING FROM lcl_pessoa.
  PUBLIC SECTION.
    DATA: numero     TYPE i,
          posicao    TYPE string,
          posse_bola TYPE boolean,
          selecao    TYPE REF TO lcl_selecao,
          chuteiras  TYPE TABLE OF REF TO lcl_chuteira,
          campo      TYPE REF TO lcl_campo.

    METHODS:
      chutar,

      movimentar
        IMPORTING
          distancia TYPE p.
ENDCLASS.

CLASS lcl_chuteira DEFINITION.
  PUBLIC SECTION.
    DATA: tamanho       TYPE i,
          marca         TYPE string,
          tamanho_trava TYPE c,
          lado          TYPE c.
ENDCLASS.

CLASS lcl_campo DEFINITION.
  PUBLIC SECTION.
    DATA: tipo_grama  TYPE string,
          largura     TYPE p,
          comprimento TYPE p,
          jogadores   TYPE TABLE OF REF TO lcl_jogador.
ENDCLASS.


CLASS lcl_pessoa IMPLEMENTATION.
  METHOD fala.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_jogador IMPLEMENTATION.
  METHOD chutar.
  ENDMETHOD.

  METHOD movimentar.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_selecao IMPLEMENTATION.
  METHOD escalar_jogador.
  ENDMETHOD.
ENDCLASS.
