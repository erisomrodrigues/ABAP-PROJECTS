@AbapCatalog.sqlViewAppendName: 'ZVP_M3A3_ERI'
@EndUserText.label: 'CDS com extensão'
extend view ZCDS_M2A2_ERI with ZCDS_M3A3_ERI
{
  _SCARR_TO_SPFLI.cityfrom,
  _SCARR_TO_SPFLI.cityto
}
