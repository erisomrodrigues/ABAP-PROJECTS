*&---------------------------------------------------------------------*
*& Report ZPROG_SINGLETON_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_singleton_eri.

CLASS best_player DEFINITION CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-METHODS:
      create_object
        IMPORTING
          name            TYPE string
          weight          TYPE p
          height          TYPE i
        RETURNING
          VALUE(r_object) TYPE REF TO best_player.

    METHODS:
      constructor
        IMPORTING
          name   TYPE string
          weight TYPE p
          height TYPE i.

    METHODS:
      display_player_details.

  PRIVATE SECTION.
    CLASS-DATA object TYPE REF TO best_player.

    DATA: name   TYPE string.
    DATA: height TYPE i.
    DATA: weight TYPE p DECIMALS 2.
ENDCLASS.

CLASS best_player IMPLEMENTATION.
  METHOD create_object.
    IF object IS NOT BOUND.
      CREATE OBJECT object
        EXPORTING
          name   = name
          weight = weight
          height = height.
    ELSE.
      WRITE:/ 'Best Player Already exists',
              'no new object created'.
    ENDIF.
    r_object = object.
  ENDMETHOD.

  METHOD constructor.
    me->name   = name.
    me->height = height.
    me->weight = weight.
  ENDMETHOD.

  METHOD display_player_details.
    WRITE:/ 'Player Name:',
          15 me->name,
          / 'Height:',
          15 me->height LEFT-JUSTIFIED,
          / 'Weight:',
          15 me->weight LEFT-JUSTIFIED.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  best_player=>create_object(
    EXPORTING
      name     = 'Player1'
      weight   = '80'
      height   = '100' )->display_player_details( ).
