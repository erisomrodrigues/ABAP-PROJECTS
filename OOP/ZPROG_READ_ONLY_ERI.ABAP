*&---------------------------------------------------------------------*
*& Report ZPROG_READ_ONLY_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_read_only_eri.

CLASS lcl_sflight DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      class_constructor,

      _pesquisa_voo
        IMPORTING
          iv_carrid     TYPE sflight-carrid
          iv_connid     TYPE sflight-connid
          iv_fldate     TYPE sflight-fldate
        RETURNING
          VALUE(result) TYPE REF TO lcl_sflight.

    METHODS:
      constructor
        IMPORTING
          is_sflight TYPE sflight,

      escrever_em_tela,

      set_s_sflight
        IMPORTING
          iv_s_sflight TYPE sflight,

      get_s_sflight
        RETURNING
          VALUE(return) TYPE Sflight.

    DATA: v_carrid TYPE sflight-carrid READ-ONLY,
          v_connid TYPE sflight-connid READ-ONLY,
          v_fldate TYPE sflight-fldate READ-ONLY.

  PRIVATE SECTION.
    CLASS-DATA: _t_flights TYPE TABLE OF REF TO lcl_sflight.

    DATA: s_sflIGHT TYPE sflight.

*    DATA: v_carrid TYPE sflight-carrid,
*          v_connid TYPE sflight-connid,
*          v_fldate TYPE sflight-fldate.
ENDCLASS.

PARAMETERS: p_carrid TYPE sflight-carrid DEFAULT 'AA',
            p_connid TYPE sflight-connid DEFAULT '0017',
            p_fldate TYPE sflight-fldate DEFAULT '20130501'.

START-OF-SELECTION.
  DATA: lo_sflight TYPE REF TO lcl_sflight.

  lo_sflight = lcl_sflight=>_pesquisa_voo( iv_carrid = p_carrid
                                           iv_connid = p_connid
                                           iv_fldate = p_fldate ).
  IF lo_sflight IS BOUND.
    MESSAGE 'Voo não encontrado' TYPE 'S' DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.

CLASS lcl_sflight IMPLEMENTATION.

  METHOD set_s_sflight.
    me->s_sflight = iv_s_sflight.
  ENDMETHOD.

  METHOD get_s_sflight.
    return = me->s_sflight.
  ENDMETHOD.

  METHOD class_constructor.
    DATA: lo_sflight TYPE REF TO lcl_sflight,
          lt_sflight TYPE TABLE OF sflight.

    FIELD-SYMBOLS: <ls_sflight> LIKE LINE OF lt_sflight.

    SELECT *
      UP TO 400 ROWS
      FROM sflight
      INTO TABLE lt_sflight.

    LOOP AT lt_sflight ASSIGNING <ls_sflight>.
      CREATE OBJECT lo_sflight
        EXPORTING
          is_sflight = <ls_sflight>.
      APPEND lo_sflight TO _t_flights.
    ENDLOOP.

  ENDMETHOD.

  METHOD _pesquisa_voo.
    READ TABLE _t_flights INTO result WITH KEY table_line->v_carrid = Iv_carrid
                                               table_line->v_connid = Iv_connid
                                               table_line->v_fldate = Iv_fldate.
  ENDMETHOD.

  METHOD constructor.
    me->v_carrid = is_sflight-carrid.
    me->v_connid = is_sflight-connid.
    me->v_fldate = is_sflight-fldate.
    me->s_sfLIGHT = is_sflight.
  ENDMETHOD.

  METHOD escrever_em_tela.
    WRITE:/ me->v_carrid,
            me->v_connid,
            me->v_fldate,
            me->s_sfLIGHT-price,
            me->s_sfLIGHT-currency,
            me->s_sfLIGHT-planetype,
            me->s_sfLIGHT-seatsmax,
            me->s_sfLIGHT-seatsocc,
            me->s_sfLIGHT-paymentsum,
            me->s_sfLIGHT-seatsmax_b,
            me->s_sfLIGHT-seatsocc_b,
            me->s_sfLIGHT-seatsmax_f,
            me->s_sfLIGHT-seatsocc_f.
  ENDMETHOD.
ENDCLASS.
