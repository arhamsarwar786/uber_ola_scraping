// To parse this JSON data, do
//
//     final fareModel = fareModelFromJson(jsonString);

import 'dart:convert';

FareModel fareModelFromJson(String str) => FareModel.fromJson(json.decode(str));

String fareModelToJson(FareModel data) => json.encode(data.toJson());

class FareModel {
    FareModel({
        this.data,
    });

    Data? data;

    factory FareModel.fromJson(Map<String, dynamic> json) => FareModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.products,
    });

    Products? products;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: Products.fromJson(json["products"]),
    );

    Map<String, dynamic> toJson() => {
        "products": products!.toJson(),
    };
}

class Products {
    Products({
        this.classificationFilters,
        this.defaultVvid,
        this.productsUnavailableMessage,
        this.renderRankingInformation,
        this.tiers,
        this.typename,
    });

    dynamic classificationFilters;
    String? defaultVvid;
    String? productsUnavailableMessage;
    bool? renderRankingInformation;
    List<Tier>? tiers;
    String? typename;

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        classificationFilters: json["classificationFilters"],
        defaultVvid: json["defaultVVID"],
        productsUnavailableMessage: json["productsUnavailableMessage"],
        renderRankingInformation: json["renderRankingInformation"],
        tiers: List<Tier>.from(json["tiers"].map((x) => Tier.fromJson(x))),
        typename: json["__typename"],
    );

    Map<String, dynamic> toJson() => {
        "classificationFilters": classificationFilters,
        "defaultVVID": defaultVvid,
        "productsUnavailableMessage": productsUnavailableMessage,
        "renderRankingInformation": renderRankingInformation,
        "tiers": List<dynamic>.from(tiers!.map((x) => x.toJson())),
        "__typename": typename,
    };
}

class Tier {
    Tier({
        this.products,
        this.title,
        this.typename,
    });

    List<Product>? products;
    String? title;
    String? typename;

    factory Tier.fromJson(Map<String, dynamic> json) => Tier(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        title: json["title"],
        typename: json["__typename"],
    );

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "title": title,
        "__typename": typename,
    };
}

class Product {
    Product({
        this.capacity,
        this.cityId,
        this.currencyCode,
        this.description,
        this.detailedDescription,
        this.discountPrimary,
        this.displayName,
        this.estimatedTripTime,
        this.etaStringShort,
        this.fare,
        this.hasFareBreakdownDisclaimer,
        this.hasPromo,
        this.hasRidePass,
        this.id,
        this.isAvailable,
        this.meta,
        this.preAdjustmentValue,
        this.productImageUrl,
        this.productUuid,
        this.reserveEnabled,
        this.typename,
    });

    int? capacity;
    String? cityId;
    String? currencyCode;
    String? description;
    String? detailedDescription;
    String? discountPrimary;
    String? displayName;
    int? estimatedTripTime;
    String? etaStringShort;
    String? fare;
    bool? hasFareBreakdownDisclaimer;
    bool? hasPromo;
    bool? hasRidePass;
    String? id;
    bool? isAvailable;
    String? meta;
    String? preAdjustmentValue;
    String? productImageUrl;
    String? productUuid;
    bool? reserveEnabled;
    String? typename;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        capacity: json["capacity"],
        cityId: json["cityID"],
        currencyCode: json["currencyCode"],
        description: json["description"],
        detailedDescription: json["detailedDescription"],
        discountPrimary: json["discountPrimary"],
        displayName: json["displayName"],
        estimatedTripTime: json["estimatedTripTime"],
        etaStringShort: json["etaStringShort"],
        fare: json["fare"],
        hasFareBreakdownDisclaimer: json["hasFareBreakdownDisclaimer"],
        hasPromo: json["hasPromo"],
        hasRidePass: json["hasRidePass"],
        id: json["id"],
        isAvailable: json["isAvailable"],
        meta: json["meta"],
        preAdjustmentValue: json["preAdjustmentValue"],
        productImageUrl: json["productImageUrl"],
        productUuid: json["productUuid"],
        reserveEnabled: json["reserveEnabled"],
        typename: json["__typename"],
    );

    Map<String, dynamic> toJson() => {
        "capacity": capacity,
        "cityID": cityId,
        "currencyCode": currencyCode,
        "description": description,
        "detailedDescription": detailedDescription,
        "discountPrimary": discountPrimary,
        "displayName": displayName,
        "estimatedTripTime": estimatedTripTime,
        "etaStringShort": etaStringShort,
        "fare": fare,
        "hasFareBreakdownDisclaimer": hasFareBreakdownDisclaimer,
        "hasPromo": hasPromo,
        "hasRidePass": hasRidePass,
        "id": id,
        "isAvailable": isAvailable,
        "meta": meta,
        "preAdjustmentValue": preAdjustmentValue,
        "productImageUrl": productImageUrl,
        "productUuid": productUuid,
        "reserveEnabled": reserveEnabled,
        "__typename": typename,
    };
}
