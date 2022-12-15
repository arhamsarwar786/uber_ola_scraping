// To parse this JSON data, do
//
//     final olaModel = olaModelFromJson(jsonString);

import 'dart:convert';

OlaModel olaModelFromJson(String str) => OlaModel.fromJson(json.decode(str));

String olaModelToJson(OlaModel data) => json.encode(data.toJson());

class OlaModel {
    OlaModel({
        this.data,
        this.error,
    });

    Data? data;
    dynamic error;

    factory OlaModel.fromJson(Map<String, dynamic> json) => OlaModel(
        data: Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "error": error,
    };
}

class Data {
    Data({
        this.nextCallAfter,
        this.p2P,
        this.fareApiParams,
    });

    int? nextCallAfter;
    P2P? p2P;
    FareApiParams? fareApiParams;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        nextCallAfter: json["nextCallAfter"],
        p2P: P2P.fromJson(json["p2p"]),
        fareApiParams: FareApiParams.fromJson(json["fareAPIParams"]),
    );

    Map<String, dynamic> toJson() => {
        "nextCallAfter": nextCallAfter,
        "p2p": p2P!.toJson(),
        "fareAPIParams": fareApiParams!.toJson(),
    };
}

class FareApiParams {
    FareApiParams({
        this.pickupZoneId,
    });

    int? pickupZoneId;

    factory FareApiParams.fromJson(Map<String, dynamic> json) => FareApiParams(
        pickupZoneId: json["pickupZoneId"],
    );

    Map<String, dynamic> toJson() => {
        "pickupZoneId": pickupZoneId,
    };
}

class P2P {
    P2P({
        this.categories,
        this.rideLater,
    });

    List<Category>? categories;
    RideLater? rideLater;

    factory P2P.fromJson(Map<String, dynamic> json) => P2P(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        rideLater: RideLater.fromJson(json["rideLater"]),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "rideLater": rideLater!.toJson(),
    };
}

class Category {
    Category({
        this.id,
        this.displayName,
        this.canRideNow,
        this.canRideLater,
        this.needDropLocation,
        this.zonalPointIds,
        this.eta,
    });

    String? id;
    String? displayName;
    bool? canRideNow;
    bool? canRideLater;
    bool? needDropLocation;
    List<int>? zonalPointIds;
    Eta? eta;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        displayName: json["displayName"],
        canRideNow: json["canRideNow"],
        canRideLater: json["canRideLater"],
        needDropLocation: json["needDropLocation"],
        zonalPointIds: List<int>.from(json["zonalPointIds"].map((x) => x)),
        eta: Eta.fromJson(json["eta"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayName,
        "canRideNow": canRideNow,
        "canRideLater": canRideLater,
        "needDropLocation": needDropLocation,
        "zonalPointIds": List<dynamic>.from(zonalPointIds!.map((x) => x)),
        "eta": eta!.toJson(),
    };
}

class Eta {
    Eta({
        this.value,
        this.unit,
    });

    int? value;
    String? unit;

    factory Eta.fromJson(Map<String, dynamic> json) => Eta(
        value: json["value"],
        unit: json["unit"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "unit": unit,
    };
}

class RideLater {
    RideLater({
        this.validDays,
        this.validTime,
    });

    int? validDays;
    int? validTime;

    factory RideLater.fromJson(Map<String, dynamic> json) => RideLater(
        validDays: json["validDays"],
        validTime: json["validTime"],
    );

    Map<String, dynamic> toJson() => {
        "validDays": validDays,
        "validTime": validTime,
    };
}
