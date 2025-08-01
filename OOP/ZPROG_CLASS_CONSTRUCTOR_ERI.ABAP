*&---------------------------------------------------------------------*
*& Report ZPROG_CLASS_CONSTRUCTOR_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_class_constructor_eri.

CLASS lcl_DOMINIO DEFINITION.
  PUBLIC SECTION.
    DATA: nome  TYPE dd01l-domname,
          tab_a TYPE TABLE OF dd07v,
          tab_b TYPE TABLE OF dd07v.

    CLASS-METHODS:
      class_constructor.

    METHODS:
      constructor
        IMPORTING
          iv_nome TYPE dd01l-domname,

      resgatar_valores.
ENDCLASS.

START-OF-SELECTION.
  DATA: lo_dominio_xfeld TYPE REF TO lcl_DOMINIO.
*  CREATE OBJECT lo_dominio_xfeld.

  CREATE OBJECT lo_dominio_xfeld
    EXPORTING
      iv_nome = 'XFELD'.


CLASS lcl_DOMINIO IMPLEMENTATION.
  METHOD resgatar_valores.
    CALL FUNCTION 'DD_DOMA_GET'
      EXPORTING
        domain_name   = nome
      TABLES
        dd07v_tab_a   = tab_a
        dd07v_tab_n   = tab_b
      EXCEPTIONS
        illegal_value = 1
        op_failure    = 2
        OTHERS        = 3.

    IF sy-subrc <> 0.
*     "Deu erro, mas nõa faça nada
    ENDIF.

  ENDMETHOD.

  METHOD constructor.
    nome = iv_nome.
    WRITE:/ 'O domínio', nome, 'foi criado'.
  ENDMETHOD.

  METHOD class_constructor.
    write:/ 'Classe iniciada'.
  ENDMETHOD.
ENDCLASS.
