*&---------------------------------------------------------------------*
*& Report Z_TEST_ERI001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_test_eri001.

CLASS lcl_animal DEFINITION.
  PUBLIC SECTION.
    METHODS:
      get_number_arms
        RETURNING VALUE(rd_result) TYPE i,

      get_number_legs
        RETURNING VALUE(rd_result) TYPE i.

  PROTECTED SECTION.
    DATA:
      md_arms TYPE i,
      md_legs TYPE i.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_animal IMPLEMENTATION.
  METHOD get_number_arms.
    rd_result = md_arms.
  ENDMETHOD.

  METHOD get_number_legs.
    rd_result = md_legs.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_cat DEFINITION INHERITING FROM lcl_animal.
  PUBLIC SECTION.
    METHODS:
      constructor.
ENDCLASS.

CLASS lcl_cat IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    md_legs = 4.
    md_arms = 0.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

DATA(lo_animal) = NEW lcl_animal( ).
DATA(ld_legs) = lo_animal->get_number_legs( ).

DATA(lo_cat) = NEW lcl_cat( ).
ld_legs = lo_cat->get_number_legs( ).

WRITE: / 'Número de pernas do gato:', ld_legs.
