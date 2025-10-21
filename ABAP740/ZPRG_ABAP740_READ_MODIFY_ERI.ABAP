*&---------------------------------------------------------------------*
*& Report ZPRG_ABAP740_READ_MODIFY_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_abap740_read_modify_eri.

TYPES: BEGIN OF ty_data,
         name TYPE char20,
         role TYPE char20,
       END OF ty_data.

DATA: lt_data TYPE STANDARD TABLE OF ty_data.

lt_data = VALUE #( ( name = 'Erisom' role = 'ABAP')
                   ( name = 'Mariane' role = 'Advogada')
                   ( name = 'Gabriel' role = 'Personal' )
                   ( name = 'Mariane' role = 'Ass.Juridico' ) ).

*cl_demo_output=>display( lt_data ).
*------------------------------------------------------------*
*           Forma de ler valores sem usar READ TABLE         *
*------------------------------------------------------------*

DATA(LS_resultado) = lt_data[ name = 'Mariane' ].
DATA(LV_resultado) = lt_data[ name = 'Mariane' ]-role.
WRITE: / LS_resultado.

*------------------------------------------------------------*
*           Formas de verificação                            *
*------------------------------------------------------------*
TRY.
    DATA(lv_role) = lt_data[ name = 'Leticia' ]-role.
  CATCH cx_sy_itab_line_not_found.
    WRITE:/ 'Not found'.
ENDTRY.


IF line_exists( lt_data[ name = 'Erisom' ] ).
  DATA(lv_name) = lt_data[ name = 'Erisom' ]-role.
  WRITE:/ lv_name.
ELSE.
  WRITE:/ 'Not found'.
ENDIF.

DATA(lv_index) = line_index( lt_data[ name = 'Gabriel'] ).
WRITE:/ lv_index.
*------------------------------------------------------------*
*           Formas de Alterar valores                        *
*------------------------------------------------------------*
cl_demo_output=>write( lt_data ).

lt_data[ name = 'Mariane']-role = 'Professora'.
lt_data[ name = 'Erisom'] = 'Ericky'.

cl_demo_output=>display( lt_data ).
