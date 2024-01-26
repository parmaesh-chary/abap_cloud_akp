@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZIAKP_DEMO_FLIGHT
  as select from /dmo/flight
  association [1] to ZIAKP_DEMO_CARRIER as _carrier on $projection.CarrierId = _carrier.CarrierId
{
      @UI.lineItem: [{ position: 20}]
      @ObjectModel.text.association: '_carrier'
  key carrier_id     as CarrierId,
      @UI.lineItem: [{ position: 30}]
  key connection_id  as ConnectionId,
      @UI.lineItem: [{ position: 40}]
  key flight_date    as FlightDate,
      @UI.lineItem: [{ position: 50}]
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price          as Price,
      currency_code  as CurrencyCode,
      @UI.lineItem: [{ position: 60}]
      @Search.defaultSearchElement: true
      plane_type_id  as PlaneTypeId,
      @UI.lineItem: [{ position: 70}]
      seats_max      as SeatsMax,
      @UI.lineItem: [{ position: 80}]
      seats_occupied as SeatsOccupied,
      _carrier
}
