@AbapCatalog.sqlViewName: 'ZVP_ASSOCIAT_ERI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS com association'
define view ZCDS_ASSOCIATION_ERI
  as select from vbak
  association [1] to vbap as _vbak_to_vbap on $projection.Vbeln = _vbak_to_vbap.vbeln
{
    key vbeln as Vbeln,
        erdat as Erdat,
        erzet as Erzet,
        ernam as Ernam,
        _vbak_to_vbap

}
