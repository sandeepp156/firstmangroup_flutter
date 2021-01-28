class DataBanners {
  DataBanners({
    this.id,
    this.title,
    this.commission,
    this.type,
    this.typeId,
    this.propertyType,
    this.typeName,
    this.image,
  });

  String id;
  String title;
  String commission;
  String type;
  String typeId;
  PropertyType propertyType;
  dynamic typeName;
  String image;

  factory DataBanners.fromJson(Map<String, dynamic> json) => DataBanners(
    id: json["id"],
    title: json["title"],
    commission: json["commission"],
    type: json["type"],
    typeId: json["type_id"],
    propertyType: propertyTypeValues.map[json["property_type"]],
    typeName: json["type_name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "commission": commission,
    "type": type,
    "type_id": typeId,
    "property_type": propertyTypeValues.reverse[propertyType],
    "type_name": typeName,
    "image": image,
  };
}

enum PropertyType { OPEN_PLOTS, APARTMENTS }

final propertyTypeValues = EnumValues({
  "Apartments": PropertyType.APARTMENTS,
  "Open Plots": PropertyType.OPEN_PLOTS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}