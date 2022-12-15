

const UBER_URL = "https://m.uber.com/graphql";

olaURL({pickUp,destination}){
 return "https://book.olacabs.com/data-api/category-availability/p2p?pickupLat=${pickUp!.latitude}&pickupLng=${pickUp!.longitude}&pickupMode=NOW&dropLat=${destination!.latitude}&dropLng=${destination!.longitude}";
  //  "https://book.olacabs.com/data-api/products/outstation?pickupLat=${pickUp!.latitude}&pickupLng=${pickUp!.longitude}&dropLat=${destination!.latitude}&dropLng=&serviceType=outstation";
}

olaURLFare({pickUp,destination}){
 return "https://book.olacabs.com/data-api/category-fare/p2p?pickupLat=${pickUp!.latitude}&pickupLng=${pickUp!.longitude}&pickupMode=NOW&dropLat=${destination!.latitude}&dropLng=${destination!.longitude}";
}

uberPayload({pickUp,destination}){
 return {"operationName":"Products","variables":{"includeClassificationFilters":false,"destinations":[{"latitude":destination!.latitude,"longitude":destination!.longitude}],"pickup":{"latitude":pickUp!.latitude,"longitude":pickUp!.longitude},"targetProductType":null},"query":"query Products(\$destinations: [InputCoordinate!]!, \$includeClassificationFilters: Boolean = false, \$pickup: InputCoordinate!, \$pickupTimeMsec: Float, \$targetProductType: EnumRVWebCommonTargetProductType) {\n  products(\n    destinations: \$destinations\n    includeClassificationFilters: \$includeClassificationFilters\n    pickup: \$pickup\n    pickupTimeMsec: \$pickupTimeMsec\n    targetProductType: \$targetProductType\n  ) {\n    ...ProductsFragment\n    __typename\n  }\n}\n\nfragment ProductsFragment on RVWebCommonProductsResponse {\n  classificationFilters {\n    ...ClassificationFiltersFragment\n    __typename\n  }\n  defaultVVID\n  productsUnavailableMessage\n  renderRankingInformation\n  tiers {\n    ...TierFragment\n    __typename\n  }\n  __typename\n}\n\nfragment ClassificationFiltersFragment on RVWebCommonClassificationFilters {\n  filters {\n    ...ClassificationFilterFragment\n    __typename\n  }\n  hiddenVVIDs\n  standardProductVVID\n  __typename\n}\n\nfragment ClassificationFilterFragment on RVWebCommonClassificationFilter {\n  currencyCode\n  displayText\n  fareDifference\n  icon\n  vvid\n  __typename\n}\n\nfragment TierFragment on RVWebCommonProductTier {\n  products {\n    ...ProductFragment\n    __typename\n  }\n  title\n  __typename\n}\n\nfragment ProductFragment on RVWebCommonProduct {\n  capacity\n  cityID\n  currencyCode\n  description\n  detailedDescription\n  discountPrimary\n  displayName\n  estimatedTripTime\n  etaStringShort\n  fare\n  hasFareBreakdownDisclaimer\n  hasPromo\n  hasRidePass\n  id\n  isAvailable\n  meta\n  preAdjustmentValue\n  productImageUrl\n  productUuid\n  reserveEnabled\n  __typename\n}\n"};
}

uberHeader(){
  return {
      "content-type": "application/json",
"cookie": "usl_rollout_id=d9366a55-5498-435e-82e5-f8972f7d22e0; marketing_vistor_id=d1f8fa52-877e-432b-ac3c-d2f1ef19e014; x-uber-analytics-session-id=b4abae5b-7f50-4745-9790-ac1dd6f8a9d0; sid=QA.CAESEAOEviRnSkSNoL6WRL27tDgY8I-EngYiATEqJGZkMTNkMTc0LTk3ODAtNGYxZi1hYmQ5LTdjNDVjYzI1M2E1NzI8NrRnVUPMycGwBnAxPq1OL144k2SoLO4VTo3k8eXcUQ2CVOmaWLZ8Nv5FuuBbotZXLjmXfL-7W9M45EITOgExQgh1YmVyLmNvbQ.-B8KN9TrJPxM_kYagfZxPlx7P7HTUuezuGsCIyqNtCY; isWebLogin=true; csid=1.1673594866689.NtwFw8yUMm11DA366iORbIYeTazhOL6ydcKLcJ1FE30=; _ua={'session_id':'8a90bf8d-f411-4f60-8662-5f1b11cd3dd6','session_time_ms':1671002866887}; udi-id=APnBCy6mhb6XAog75iDOws1d7GICeQGe4c0NLQe5FqLm2GoTymayjg2fIbqEgYPvY3ZsraFPzyT6ZPEeIgh3bf727LgXbGUr97qcQELUzAYsgxBPtTdIWq+/e2YHg7VtoFib2SXQTe0/2fytnU4Ej4+qa1rIhcbCMqQlCw3PvHCgkoBEAUay1fIYcxBGRSs3U7Z5JoAOh99iJSAyduagFg==a8X5gMtqRgnDyAvEcC2+9Q==2URXQ35vYlVFZQU1xd0hJRK+otV4BYDuoqOaReKK8nw=; mp_adec770be288b16d9008c964acfba5c2_mixpanel=%7B%22distinct_id%22%3A%20%22fd13d174-9780-4f1f-abd9-7c45cc253a57%22%2C%22%24device_id%22%3A%20%221850f8846db325-0577931df6fae9-17525635-13c680-1850f8846dc9b8%22%2C%22%24initial_referrer%22%3A%20%22https%3A%2F%2Fauth.uber.com%2F%22%2C%22%24initial_referring_domain%22%3A%20%22auth.uber.com%22%2C%22%24user_id%22%3A%20%22fd13d174-9780-4f1f-abd9-7c45cc253a57%22%7D; _cc=AX4F9yn0ouxORDUnnDr6Jy9S; udi-fingerprint=oi2ORModa5gjdzAKK0hSeYZb8xfrIyyiBHqhdw+S/yFnGXosdI/7sENewPWy47dhAi3WerXdocggq6CDoCgNHQ==AOniNXQNR29u124zRrTgZ53v+StfQErsRRrVKiYR5Gg=; jwt-session=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7InNlc3Npb25fdHlwZSI6ImRlc2t0b3Bfc2Vzc2lvbiIsInRlbmFuY3kiOiJ1YmVyL3Byb2R1Y3Rpb24ifSwiaWF0IjoxNjcxMDAyODY2LCJleHAiOjE2NzEwODkyNjZ9.IZ1DixV5Qi12eVQp56HatxJ9N9sfWuocPQGapKce9v0; _csid=1.1671003171366.720h.dca22.cxBK/UaqEUfA886hCr0wQTuHIvkASDCSma5GUSTlN6Q=",
"x-csrf-token":"x"
    };
}

olaHeader(){
  return {
    "content-type": "application/json",
"cookie": "_ga=GA1.2.1456987845.1671021015; _gid=GA1.2.1141677039.1671021015; _gcl_au=1.1.1952628348.1671021044; wasc=web-64ba5b0e-6a32-4f2e-bf0f-3f448b0dc1a6__AQECAHgfxP3kLfatAqX5D3Wm8Q4cwpCiqFMlbQIth8I9m4HyQQAAANswgdgGCSqGSIb3DQEHBqCByjCBxwIBADCBwQYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAxSbgmBCju8pgQqhq0CARCAgZMXJ7%2FXiLnkEl48IjAXiCwRI0%2BaaF5y47CXtu5AtmyPYrCy1C9FDcO6QuY%2BiloOVeR9izcSHyk4j78S6mmsynaElSEDBfFNoXzyqoYBEmAjEYJFtSMP1scpdcbu8IweOjAIk%2Fp%2BzgtDrvcTWktwAz%2BRxk36hkKcPICbkDFRcp6wiManBq6fU%2BThUwLErDmmvC%2F8QdY%3D; OSRN_v1=BE_-lIBNJzSVuWNIBdL-ctJn; _csrf=815ruk6_zsZoCGTMGIN7gxbl; XSRF-TOKEN=zS9Jzqd2-JbvZiXxY3HjuoV5gbwg4s3HFm6U; _gat=1",
"x-requested-with": "XMLHttpRequest"
  };
}