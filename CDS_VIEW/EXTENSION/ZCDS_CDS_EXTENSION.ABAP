@AbapCatalog.sqlViewAppendName: 'ZVP_EXTENSIO_ERI'
@EndUserText.label: 'CDS com extensão'
extend view ZCDS_ASSOCIATION_ERI with ZCDS_CDS_EXTENSION_ERI
{
  _vbak_to_vbap.matnr,
  _vbak_to_vbap.posnr
}
