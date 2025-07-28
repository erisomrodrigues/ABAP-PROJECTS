*&---------------------------------------------------------------------*
*& Report ZPROG_CREATE_INSTANCE_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_create_instance_eri.

CLASS lcl_loucutor DEFINITION.
  PUBLIC SECTION.
    DATA: nome           TYPE string,
          idade          TYPE i,
          utima_mensagem TYPE string.

    METHODS:
      falar
        IMPORTING
          iv_mensagem TYPE string.
ENDCLASS.

START-OF-SELECTION.

  "Modo antigo
*  DATA: lo_loucutor TYPE REF TO lcl_loucutor.
*  CREATE OBJECT lo_loucutor.

  "ABAP 7.4
  DATA(lo_loucutor) = NEW lcl_loucutor( ).

  IF lo_loucutor IS NOT BOUND.
    WRITE:/ 'Objeto não criado'.
  ELSE.
    WRITE:/ 'Objeto criado'.
  ENDIF.

CLASS lcl_loucutor IMPLEMENTATION.
  METHOD falar.
  ENDMETHOD.
ENDCLASS.
