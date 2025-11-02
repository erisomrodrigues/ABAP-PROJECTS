@AbapCatalog.sqlViewName: 'ZVP_M2A2_ERI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS com association'
define view ZCDS_M2A2_ERI
  as select from scarr
  association [1] to spfli as _SCARR_TO_SPFLI on $projection.Carrid = _SCARR_TO_SPFLI.carrid
{
  key carrid                   as Carrid,
      carrname                 as Carrname,
      currcode                 as Currcode,
      url                      as Url,
      _SCARR_TO_SPFLI
//      _SCARR_TO_SPFLI.cityfrom as cityFrom
}
