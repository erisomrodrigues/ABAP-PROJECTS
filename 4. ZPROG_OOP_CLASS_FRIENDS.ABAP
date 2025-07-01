class ZCL_ANA_ERI definition
  public
  final
  create public

  global friends ZCL_MARIA_ERI .

public section.

  data MD_NOME type CHAR100 value 'Ana' ##NO_TEXT.

  methods SITUACAO_FINANCEIRA .
protected section.
private section.

  data MD_SALDO_BANCARIO type NETWR value '-1500.12' ##NO_TEXT.

  methods COMPRAR
    importing
      !ID_VALOR type NETWR .
ENDCLASS.



CLASS ZCL_ANA_ERI IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_ANA_ERI->COMPRAR
* +-------------------------------------------------------------------------------------------------+
* | [--->] ID_VALOR                       TYPE        NETWR
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method COMPRAR.
    me->md_saldo_bancario = me->md_saldo_bancario - id_valor.
  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ANA_ERI->SITUACAO_FINANCEIRA
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD situacao_financeira.
    IF me->md_saldo_bancario < 0.
      WRITE:/ |{ md_nome }: Estou devendo :(|.
    ELSEIF me->md_saldo_bancario = 0.
      WRITE:/ |{ md_nome }: Estou Zerada :/|.
    ELSE.
      WRITE:/ |{ md_nome }: Tenho Grana :)|.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

*&---------------------------------------------------------------------*
*& Report ZPROG_CLASSES_FRIENDS_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_classes_friends_eri.

START-OF-SELECTION.

  DATA lo_ana TYPE REF TO zcl_ana_eri.
  DATA lo_maria TYPE REF TO zcl_maria_eri.

  LO_ana = NEW zcl_ana_eri( ).
  LO_Maria = NEW zcl_maria_eri( ).

  lo_ana->situacao_financeira( ).
  lo_maria->revelar_segredos( io_ana = lo_ana ).
  lo_maria->revelar_segredos( io_ana = lo_ana ).
