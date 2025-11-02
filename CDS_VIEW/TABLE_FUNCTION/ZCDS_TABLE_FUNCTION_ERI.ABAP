@EndUserText.label: 'CDS com table fuction'
define table function ZCDS_TABLE_FUNCTION_ERI
  with parameters
    @Environment.systemField: #CLIENT
    client : abap.clnt
returns
{
  key client : abap.clnt;
  key vbeln  : veben;
      erdat  : erdat;
      ernam  : ernam;
      netwr  : netwr;
      posnr  : posnr;
      matnr  : matnr;

}
implemented by method
  zcl_amdp_table_function_eri=>GET_SALES_ORDER;
