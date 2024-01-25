@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_AKP_CONNECTION'
define root view entity ZC_AKP_CONNECTION
  provider contract transactional_query
  as projection on ZR_AKP_CONNECTION
{
  key UUID,
  CarrierID,
  ConnectionID,
  AirportFromID,
  CityFrom,
  CountryFrom,
  AirportToID,
  CityTo,
  CountryTo,
  LocalLastChangedAt
  
}
