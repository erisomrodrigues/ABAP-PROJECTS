*&---------------------------------------------------------------------*
*& Report ZTESTE_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zteste_eri.

CLASS lcl_cliente DEFINITION.
  PUBLIC SECTION.
    METHODS set_cpf
      IMPORTING
        id_cpf TYPE char11.

    METHODS get_cpf
      RETURNING
        VALUE(rd_cpf) TYPE char11.

    METHODS set_nome
      IMPORTING
        id_nome TYPE string.

    METHODS get_nome
      RETURNING
        VALUE(rd_nome) TYPE string.

    METHODS get_cpf_formatado
      RETURNING
        VALUE(rd_cpf) TYPE string.

  PRIVATE SECTION.
    DATA md_cpf TYPE char11.
    DATA md_nome TYPE string.

ENDCLASS.

CLASS lcl_cliente IMPLEMENTATION.
  METHOD set_cpf.
    IF strlen( id_cpf ) <> '11'.
      RETURN.
    ENDIF.

    me->md_cpf = id_cpf.
  ENDMETHOD.

  METHOD get_cpf.
    rd_cpf = md_cpf.
  ENDMETHOD.

  METHOD set_nome.
    me->md_nome = id_nome.
  ENDMETHOD.

  METHOD get_nome.
    rd_nome = md_nome.
  ENDMETHOD.

  METHOD get_cpf_formatado.
    CONCATENATE md_cpf+0(3) '.' md_cpf+3(3) '.' md_cpf+6(3) '-' md_cpf+9(2) INTO rd_cpf.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  DATA: lo_cliente1 TYPE REF TO lcl_cliente.

  lo_cliente1 = NEW lcl_cliente( ).

  lo_cliente1->set_cpf( id_cpf = '12345678910' ).

  WRITE:/ lo_cliente1->get_cpf( ),
        / lo_cliente1->get_cpf_formatado( ).
