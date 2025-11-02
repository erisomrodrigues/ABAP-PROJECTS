CLASS zcl_amdp_table_function_eri DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS: get_sales_order FOR TABLE FUNCTION zcds_table_function_eri.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_amdp_table_function_eri IMPLEMENTATION.
  METHOD get_sales_order BY DATABASE
                             FUNCTION FOR HDB
                             LANGUAGE SQLSCRIPT
                             USING vbak vbap.

    RETURN SELECT vk.mandt as client,
                  vk.vbeln,
                  vk.erdat,
                  vk.ernam,
                  vk.netwr,
                  vp.posnr,
                  vp.matnr
             from vbak as vk
            inner join vbap as vp
               on vk.vbeln = vp.vbeln
            order by vk.vbeln;
  endmethod.

ENDCLASS.
