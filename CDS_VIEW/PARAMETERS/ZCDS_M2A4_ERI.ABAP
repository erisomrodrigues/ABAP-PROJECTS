@AbapCatalog.sqlViewName: 'ZVP_M2A4_ERI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS com parametros'
define view ZCDS_M2A4_ERI
    with parameters p_moeda : abap.char( 3 ) 
    as select from scarr
{
    key carrid as Carrid,
    carrname as Carrname,
    currcode as Currcode,
    url as Url
} where currcode = $parameters.p_moeda
