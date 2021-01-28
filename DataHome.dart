class DataHome {
  DataHome({
    this.banners,
    this.announces,
    this.offers,
    this.installations,
    this.toppers,
    this.bannerText,
  });

  List<Banner> banners;
  int announces;
  int offers;
  int installations;
  List<Topper> toppers;
  List<BannerText> bannerText;

  factory DataHome.fromJson(Map<String, dynamic> json) => DataHome(
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    announces: json["announces"],
    offers: json["offers"],
    installations: json["installations"],
    toppers: List<Topper>.from(json["toppers"].map((x) => Topper.fromJson(x))),
    bannerText: List<BannerText>.from(json["banner_text"].map((x) => BannerText.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    "announces": announces,
    "offers": offers,
    "installations": installations,
    "toppers": List<dynamic>.from(toppers.map((x) => x.toJson())),
    "banner_text": List<dynamic>.from(bannerText.map((x) => x.toJson())),
  };
}

class BannerText {
  BannerText({
    this.id,
    this.title,
    this.link,
    this.image,
    this.description,
    this.bigDescription,
  });

  String id;
  String title;
  String link;
  String image;
  String description;
  String bigDescription;

  factory BannerText.fromJson(Map<String, dynamic> json) => BannerText(
    id: json["id"],
    title: json["title"],
    link: json["link"],
    image: json["image"],
    description: json["description"],
    bigDescription: json["big_description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "link": link,
    "image": image,
    "description": description,
    "big_description": bigDescription,
  };
}

class Banner {
  Banner({
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

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
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

class Topper {
  Topper({
    this.id,
    this.name,
    this.memberCode,
  });

  String id;
  String name;
  String memberCode;

  factory Topper.fromJson(Map<String, dynamic> json) => Topper(
    id: json["id"],
    name: json["name"],
    memberCode: json["member_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "member_code": memberCode,
  };
}

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