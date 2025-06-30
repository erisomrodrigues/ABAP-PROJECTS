class ZCL_MARIA_ERI definition
  public
  final
  create public .

public section.

  methods REVELAR_SEGREDOS
    importing
      !IO_ANA type ref to ZCL_ANA_ERI .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MARIA_ERI IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_MARIA_ERI->REVELAR_SEGREDOS
* +-------------------------------------------------------------------------------------------------+
* | [--->] IO_ANA                         TYPE REF TO ZCL_ANA_ERI
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method REVELAR_SEGREDOS.
    WRITE:/ |A minha amiga ana tem R$ { io_ana->md_saldo_bancario } de saldo bancário pessoal|.

    io_ana->comprar( id_valor = 500 ).
  endmethod.
ENDCLASS.
