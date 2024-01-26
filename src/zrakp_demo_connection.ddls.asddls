@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection Details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI: {                                                    //Header Information on Line Items
  headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'List of Connections'
  }
}
@Search.searchable: true
define view entity ZRAKP_DEMO_CONNECTION
  as select from /dmo/connection
  association [1..*] to ZIAKP_DEMO_FLIGHT  as _flight  on  $projection.CarrierId    = _flight.CarrierId
                                                       and $projection.ConnectionId = _flight.ConnectionId
  association [1]    to ZIAKP_DEMO_CARRIER as _carrier on  $projection.CarrierId = _carrier.CarrierId
{
      @UI.facet: [ {
          id: 'Connection',
          type: #IDENTIFICATION_REFERENCE,
          label: 'Connection Details',
          position: 10
        },
        {
          id : 'Flight',
          type: #LINEITEM_REFERENCE,
          label: 'Flight Details',
          position: 20,
          targetElement: '_flight'
        }]
      @UI.lineItem: [{ position: 10 , label: 'Airline_ID'}] //To Display the Line Items
      @UI.identification: [{ position: 10 }]                //To Dispaly the Object page Line Items
      //@UI.selectionField: [{ position: 10  }]               //Selection Field - Filter Option
      @ObjectModel.text.association: '_carrier' //Get the details from _carrier association Carrier Name based on Carrier ID
      //@Search.defaultSearchElement: true
  key carrier_id      as CarrierId,
      @UI.lineItem: [{ position: 20}]
      @UI.identification: [{ position: 20 }]
      //@UI.selectionField: [{ position: 20  }]
      //@Search.defaultSearchElement: true
  key connection_id   as ConnectionId,
      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      @UI.selectionField: [{ position: 30  }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: //Value help addition
      [
        { entity :
            { 
            name: 'ZIAKP_DEMO_AIRPORT_VH',
            element: 'AirportId'
            } 
        }
      ]
      airport_from_id as AirportFromId,
      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      @UI.selectionField: [{ position: 40  }]
      @Search.defaultSearchElement: true
       @Consumption.valueHelpDefinition: 
      [
        { entity :
            { 
            name: 'ZIAKP_DEMO_AIRPORT_VH',
            element: 'AirportId'
            } 
        }
      ]
      airport_to_id   as AirportToId,
      @UI.lineItem: [{ position: 50 ,label:'DepartureTime'}]
      @UI.identification: [{ position: 50 ,label:'DepartureTime' }]
      departure_time  as DepartureTime,
      @UI.lineItem: [{ position: 60 ,label:'ArrivalTime'}]
      @UI.identification: [{ position: 60  ,label:'ArrivalTime'}]
      arrival_time    as ArrivalTime,
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      @UI.lineItem: [{ position: 70 }]
      @UI.identification: [{ position: 70 }]
      distance        as Distance,
      distance_unit   as DistanceUnit,
      @Search.defaultSearchElement: true //Assocation is searchbale - The respective View should be searchble
      _flight, //Public Expose
      @Search.defaultSearchElement: true
      _carrier
}
