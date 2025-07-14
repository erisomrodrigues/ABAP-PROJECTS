*&---------------------------------------------------------------------*
*& Report ZPROG_OOP_001_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_oop_001_eri.
CLASS lcl_cliente DEFINITION.
  PUBLIC SECTION.
    METHODS set_cpf
      IMPORTING id_cpf TYPE char11.

    METHODS get_cpf RETURNING
                      VALUE(rd_cpf) TYPE char11.

    METHODS get_cpf_formatado
      RETURNING
        VALUE(rd_cpf) TYPE char14.

    METHODS set_nome
      IMPORTING id_nome TYPE string.

    METHODS get_nome
      RETURNING
        VALUE(rd_nome) TYPE string.

  PRIVATE SECTION.
    DATA: md_cpf TYPE char11.
    DATA: md_nome TYPE string.

ENDCLASS.
CLASS lcl_pedido DEFINITION.
  PUBLIC SECTION.
    METHODS set_cliente
      IMPORTING io_cliente TYPE REF TO lcl_cliente.

    METHODS get_cliente
      RETURNING
        VALUE(ro_cliente) TYPE REF TO lcl_cliente.

"Comentar PRIVATE_SECTION para mostrar diferença entre private e public
*  PRIVATE SECTION.
    DATA mo_cliente TYPE REF TO lcl_cliente.
ENDCLASS.

CLASS lcl_cliente IMPLEMENTATION.
  METHOD set_cpf.
    IF strlen( id_cpf ) <> 11.
      RETURN.
    ENDIF.
    me->md_cpf = id_cpf.
  ENDMETHOD.

  METHOD get_cpf.
    rd_cpf = md_cpf.
  ENDMETHOD.

  METHOD get_cpf_formatado.
    CONCATENATE md_cpf+0(3) '.' md_cpf+3(3) '.' md_cpf+6(3) '-' md_cpf+9(2) INTO rd_cpf.
  ENDMETHOD.

  METHOD set_nome.
    me->md_nome = id_nome.
  ENDMETHOD.

  METHOD get_nome.
    rd_nome = md_nome.
  ENDMETHOD.

ENDCLASS.
CLASS lcl_pedido IMPLEMENTATION.
  METHOD set_cliente.
    mo_cliente = io_cliente.
  ENDMETHOD.

  METHOD get_cliente.
    ro_cliente = mo_cliente.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA lo_cliente TYPE REF TO lcl_cliente.
  DATA lo_pedido  TYPE REF TO lcl_pedido.

  lo_cliente = NEW lcl_cliente( ).
  lo_pedido = NEW lcl_pedido( ).

  lo_cliente->set_cpf( id_cpf = '12345678910' ).
  lo_cliente->set_nome( id_nome = 'ERISOM' ).
  lo_pedido->set_cliente( io_cliente = lo_cliente ).
*  lo_pedido->set_cliente( io_cliente = lo_cliente ).
  lo_pedido->mo_cliente->set_nome( id_nome = lo_cliente->get_nome( ) ). "O MO_CLIENTE-> só aparece devido alterãção de private section para public section.

  WRITE lo_cliente->get_cpf( ).
  ULINE.
  WRITE / lo_cliente->get_cpf_formatado( ).
  ULINE.
  WRITE lo_pedido->get_cliente( )->get_nome( ).
