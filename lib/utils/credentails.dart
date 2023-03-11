const UBER_URL = "https://m.uber.com/graphql";

olaURL({pickUp, destination}) {
  return "https://book.olacabs.com/data-api/category-availability/p2p?pickupLat=${pickUp!.latitude}&pickupLng=${pickUp!.longitude}&pickupMode=NOW&dropLat=${destination!.latitude}&dropLng=${destination!.longitude}";
  //  "https://book.olacabs.com/data-api/products/outstation?pickupLat=${pickUp!.latitude}&pickupLng=${pickUp!.longitude}&dropLat=${destination!.latitude}&dropLng=&serviceType=outstation";
}

olaURLFare({pickUp, destination}) {
   return "https://book.olacabs.com/data-api/category-fare/p2p?pickupLat=${pickUp!.latitude}&pickupLng=${pickUp!.longitude}&pickupMode=NOW&leadSource=desktop_website&dropLat=${destination!.latitude}&dropLng=${destination!.longitude}";

  // return "https://book.olacabs.com/data-api/category-fare/p2p?pickupLat=${pickUp!.latitude}&pickupLng=${pickUp!.longitude}&dropLat=${destination!.latitude}&dropLng=${destination!.longitude}";
}

uberPayload({pickUp, destination}) {
  return {
    "operationName": "Products",
    "variables": {
      "includeClassificationFilters": false,
      "destinations": [
        {"latitude": destination!.latitude, "longitude": destination!.longitude}
      ],
      "pickup": {"latitude": pickUp!.latitude, "longitude": pickUp!.longitude},
      "targetProductType": null
    },
    "query":
        "query Products(\$destinations: [InputCoordinate!]!, \$includeClassificationFilters: Boolean = false, \$pickup: InputCoordinate!, \$pickupTimeMsec: Float, \$targetProductType: EnumRVWebCommonTargetProductType) {\n  products(\n    destinations: \$destinations\n    includeClassificationFilters: \$includeClassificationFilters\n    pickup: \$pickup\n    pickupTimeMsec: \$pickupTimeMsec\n    targetProductType: \$targetProductType\n  ) {\n    ...ProductsFragment\n    __typename\n  }\n}\n\nfragment ProductsFragment on RVWebCommonProductsResponse {\n  classificationFilters {\n    ...ClassificationFiltersFragment\n    __typename\n  }\n  defaultVVID\n  productsUnavailableMessage\n  renderRankingInformation\n  tiers {\n    ...TierFragment\n    __typename\n  }\n  __typename\n}\n\nfragment ClassificationFiltersFragment on RVWebCommonClassificationFilters {\n  filters {\n    ...ClassificationFilterFragment\n    __typename\n  }\n  hiddenVVIDs\n  standardProductVVID\n  __typename\n}\n\nfragment ClassificationFilterFragment on RVWebCommonClassificationFilter {\n  currencyCode\n  displayText\n  fareDifference\n  icon\n  vvid\n  __typename\n}\n\nfragment TierFragment on RVWebCommonProductTier {\n  products {\n    ...ProductFragment\n    __typename\n  }\n  title\n  __typename\n}\n\nfragment ProductFragment on RVWebCommonProduct {\n  capacity\n  cityID\n  currencyCode\n  description\n  detailedDescription\n  discountPrimary\n  displayName\n  estimatedTripTime\n  etaStringShort\n  fare\n  hasFareBreakdownDisclaimer\n  hasPromo\n  hasRidePass\n  id\n  isAvailable\n  meta\n  preAdjustmentValue\n  productImageUrl\n  productUuid\n  reserveEnabled\n  __typename\n}\n"
  };
}

uberHeader() {
  return {
    "content-type": "application/json",
    "cookie":
        "marketing_vistor_id=74a5870b-4f1b-4553-82e4-1082ebac546c; optimizelyEndUserId=oeu1678343108878r0.3695523780263843; UBER_CONSENTMGR=1678343110942|consent:true; segmentCookie=b; utag_geo_code=US; _gcl_au=1.1.287499082.1678343113; _ga_XTGQLY6KPT=GS1.1.1678343113.1.0.1678343113.0.0.0; CONSENTMGR=1678343110943:undefined%7Cconsent:true; utag_main=v_id:0186c50b876e001643e54211e71a03075001b06d00942\$_sn:1\$_se:2\$_ss:0\$_st:1678344913994\$ses_id:1678343112560%3Bexp-session\$_pn:1%3Bexp-session\$segment:b\$optimizely_segment:b; _ga=GA1.2.511316320.1678343114; _gid=GA1.2.1770928455.1678343114; usl_rollout_id=d232a55d-c330-4094-babb-10d1db816ed3; x-uber-analytics-session-id=2bfa431c-591c-461a-bef5-6870e8ddde4b; sid=QA.CAESEJIf941FJ0Ntvs2-tDyv9iAY2ZHEoQYiATEqJGZkMTNkMTc0LTk3ODAtNGYxZi1hYmQ5LTdjNDVjYzI1M2E1NzI89l7184eyqjGaSA8_-yitB2bMGwqAvL4gl6dEL7NUTPIfeYUXr9ECjx3_wFuFNB8CX3UKe0y38xO973v8OgExQgh1YmVyLmNvbQ.wTeZ1FduxzSns068DwFkxFsTBnFP8l2n1nfW1Ve4DAI; csid=1.1680935129995.WiFxVH8yaE01X3nm+uuZ4OX19TEq/Zr1Nqay/OIafQk=; _ua={'session_id':'8ff6467b-283d-47aa-8e66-acc1434fc2a9','session_time_ms':1678343130300}; udi-id=r35T+2kVHomz5lQHstLtMXhbtAcoaN1BvorEEYSNOB9OUMkGvN13dENBKidndKJ92QffcT2PojQ/iGbZz0qoKnrlw0K3nQ40PRhfJWTCnY284+AT1UhE36BYthBMwDFuxK+V7yGXPwNZ50IHcZiD689PmNiio6+rUJKHZxVBb3SpBwwCTXhi6afNGg9/YfpUfIN0YmzKVp40rDacKwQ+Wg==nnGgQiPAeUlKYJ9jAc3yZw==Tf3dieywdvj0Gqc+h+rdXAjghDtwUg/HSodxeEnfuf0=; mp_adec770be288b16d9008c964acfba5c2_mixpanel=%7B%22distinct_id%22%3A%20%22fd13d174-9780-4f1f-abd9-7c45cc253a57%22%2C%22%24device_id%22%3A%20%22186c50b7fd441a-0a1ea620030c6f-1f525634-13c680-186c50b7fd55df%22%2C%22%24initial_referrer%22%3A%20%22%24direct%22%2C%22%24initial_referring_domain%22%3A%20%22%24direct%22%2C%22%24user_id%22%3A%20%22fd13d174-9780-4f1f-abd9-7c45cc253a57%22%7D; _cc=AbFmRlVHYNqTrkMiRUzSKAJ4; udi-fingerprint=7jEN2XjFV02UIzkrMo7x/2eZu+iqxW5+nH/8nb5MZvxwnAq8P2RXj6uvCltUN+3gg9oaOpwvw961xSLwCu/k6A==LlV+6mnmFu5cP6OIMRX1itU1weUBbyrGN9sVNzYZVBo=; jwt-session=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7InNlc3Npb25fdHlwZSI6ImRlc2t0b3Bfc2Vzc2lvbiIsInRlbmFuY3kiOiJ1YmVyL3Byb2R1Y3Rpb24ifSwiaWF0IjoxNjc4MzQzMTMwLCJleHAiOjE2Nzg0Mjk1MzB9.4AG5m-OBlnfUBUEPFuzaHyim6A8jSV_HUbn5btB0jwc; allow-geolocation=true",
    "x-csrf-token": "x"
  };
}

olaHeader() {
  return {
    "content-type": "application/json",
    "cookie":
        "_ga=GA1.2.637351571.1678345149; _gid=GA1.2.460373936.1678345149; OSRN_v1=6HwqIdYC-B91o8XoUuChcaqO; _csrf=bQWXzxehtNLpaFn6TN2nsdLR; XSRF-TOKEN=EOuvjjAc-e_dgudeAy3XC1k4q4VZBrF3kW5Y; _gcl_au=1.1.112006568.1678345198; wasc=web-7a1f1c8d-ad18-4f58-8033-9a9e1038c3ea__AQECAHgfxP3kLfatAqX5D3Wm8Q4cwpCiqFMlbQIth8I9m4HyQQAAANswgdgGCSqGSIb3DQEHBqCByjCBxwIBADCBwQYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAyYuklWC1W6jA8GvhYCARCAgZPqe0BGa6dT7RnugEg0%2FyKa253QPq7j%2B8G%2BqzZMGGM6KP%2FyEQKsOqTkzzWkjZRLGtIY8mwpF%2FaVADcMUcnMu29mXXSk5ZiF81OTRUwP9ZscCC4aNyFiblVGbR3j774rwBokM1nj%2B%2B2Y5U9hQMjXv2%2B7zDJ0WEJcTYpdA1pDb87ClIJgQ8Bc6gFCgzSGOJWJoRzvx5w%3D",
    "x-requested-with": "XMLHttpRequest"
  };
}
