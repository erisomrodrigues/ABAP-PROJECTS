@AbapCatalog.sqlViewName: 'ZVP_PARAMETE_ERI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS com parameter'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_PARAMETER_ERI
  with parameters
    P_SPRAS : spras
  as select from    mara as T1
    left outer join makt as T2 on T1.matnr = T2.matnr
{
  key T1.matnr           as Matnr,
      T1.ersda           as Ersda,
      T1.created_at_time as CreatedAtTime,
      T1.mtart           as Mtart,
      T1.matkl           as Matlk,
      T2.maktx           as Maktx,
      T2.spras           as Spras
}
where
  spras = :P_SPRAS

