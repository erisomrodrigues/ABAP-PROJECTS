*&---------------------------------------------------------------------*
*& Report ZPROG_CONSTRUCTOR_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_constructor_eri.

* Constructor de instancia
CLASS lcl_demo DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    METHODS display.

  PRIVATE SECTION.
    DATA gv_text TYPE string.
ENDCLASS.

CLASS lcl_demo IMPLEMENTATION.
  METHOD constructor.
    gv_text = 'Hello from constructor'.
  ENDMETHOD.

  METHOD display.
    WRITE: / gv_text.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
DATA lo_demo TYPE REF TO lcl_demo.
lo_demo = NEW lcl_demo( ).

lo_demo->display( ).

* Constructor estatico
CLASS lcl_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS class_constructor.
    CLASS-METHODS show.
  PRIVATE SECTION.
    CLASS-DATA gv_static_text TYPE string.
ENDCLASS.

CLASS lcl_demo IMPLEMENTATION.
  METHOD class_constructor.
    gv_static_text = 'Static Init Done'.
  ENDMETHOD.

  METHOD show.
    WRITE: / gv_static_text.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
lcl_demo=>show( ).
