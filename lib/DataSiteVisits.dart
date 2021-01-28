class DataSiteVisits {
  DataSiteVisits({
    this.month,
    this.leads,
  });

  String month;
  List<Lead> leads;

  factory DataSiteVisits.fromJson(Map<String, dynamic> json) => DataSiteVisits(
    month: json["date"],
    leads: List<Lead>.from(json["visits"].map((x) => Lead.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": month,
    "visits": List<dynamic>.from(leads.map((x) => x.toJson())),
  };
}

class Lead {
  Lead({
    this.id,
    this.leadId,
    this.name,
    this.phone,
    this.email,
    this.city,
    this.type,
    this.propertyType,
    this.propertyCategory,
    this.propertyId,
    this.bhkStr,
    this.areaDisp,
    this.loanType,
    this.bank,
    this.salaried,
    this.loanReq,
    this.insuranceType,
    this.amount,
    this.area,
    this.rmSupport,
    this.comments,
    this.curStatus,
    this.date,
    this.tracking,
  });

  String id;
  String leadId;
  String name;
  String phone;
  String email;
  String city;
  String type;
  // Property propertyType;
  String propertyType;
  Property propertyCategory;
  PropertyId propertyId;
  BhkStr bhkStr;
  String areaDisp;
  String loanType;
  String bank;
  Salaried salaried;
  String loanReq;
  String insuranceType;
  String amount;
  String area;
  RmSupport rmSupport;
  String comments;
  String curStatus;
  String date;
  List<Tracking> tracking;

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
    id: json["id"],
    leadId: json["lead_id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    // city: cityValues.map[json["city"]],
    city: json["city"],
    type: json["type"],
    propertyType:json["property_type"],
    // propertyType: propertyValues.map[json["property_type"]],
    propertyCategory: propertyValues.map[json["property_category"]],
    propertyId: PropertyId.fromJson(json["property_id"]),
    bhkStr: bhkStrValues.map[json["bhk_str"]],
    areaDisp: json["area_disp"],
    loanType: json["loan_type"],
    bank: json["bank"],
    salaried: salariedValues.map[json["salaried"]],
    loanReq: json["loan_req"],
    insuranceType: json["insurance_type"],
    amount: json["amount"],
    area: json["area"],
    // area: areaValues.map[json["area"]],
    rmSupport: rmSupportValues.map[json["rm_support"]],
    comments: json["comments"],
    curStatus: json["cur_status"],
    // curStatus: curStatusValues.map[json["cur_status"]],
    date: json["date"],
    tracking: List<Tracking>.from(json["tracking"].map((x) => Tracking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "name": name,
    "phone": phone,
    "email": email,
    "city": cityValues.reverse[city],
    "type": type,
    "property_type": propertyType,
    // "property_type": propertyValues.reverse[propertyType],
    "property_category": propertyValues.reverse[propertyCategory],
    "property_id": propertyId.toJson(),
    "bhk_str": bhkStrValues.reverse[bhkStr],
    "area_disp": areaDisp,
    "loan_type": loanType,
    "bank": bank,
    "salaried": salariedValues.reverse[salaried],
    "loan_req": loanReq,
    "insurance_type": insuranceType,
    "amount": amount,
    "area": area,
    "rm_support": rmSupportValues.reverse[rmSupport],
    "comments": comments,
    "cur_status": curStatus,
    "date": date,
    "tracking": List<dynamic>.from(tracking.map((x) => x.toJson())),
  };
}

enum Area { VEERAVALLI, CHINNA_TIRUPATHI, ELLURU_CENTRAL }

final areaValues = EnumValues({
  "Chinna Tirupathi": Area.CHINNA_TIRUPATHI,
  "Elluru Central": Area.ELLURU_CENTRAL,
  "veeravalli": Area.VEERAVALLI
});

enum BhkStr { DHATRI_HOUSING_PROJECTS, DHATRI_HOUSING_PROJECTS_PRIVATE_LIMITED }

final bhkStrValues = EnumValues({
  "Dhatri Housing projects": BhkStr.DHATRI_HOUSING_PROJECTS,
  "Dhatri Housing Projects Private Limited": BhkStr.DHATRI_HOUSING_PROJECTS_PRIVATE_LIMITED
});

enum City { VIJAYAWADA, ELURU }

final cityValues = EnumValues({
  "Eluru": City.ELURU,
  "Vijayawada": City.VIJAYAWADA
});

enum CurStatus { PENDING, PAID }

final curStatusValues = EnumValues({
  "Paid": CurStatus.PAID,
  "Pending": CurStatus.PENDING
});

enum Property { OPEN_PLOTS }

final propertyValues = EnumValues({
  "Open Plots": Property.OPEN_PLOTS
});

class PropertyId {
  PropertyId({
    this.id,
    this.title,
    this.propCode,
  });

  String id;
  PropertyIdTitle title;
  PropCode propCode;

  factory PropertyId.fromJson(Map<String, dynamic> json) => PropertyId(
    id: json["id"],
    title: propertyIdTitleValues.map[json["title"]],
    propCode: propCodeValues.map[json["prop_code"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": propertyIdTitleValues.reverse[title],
    "prop_code": propCodeValues.reverse[propCode],
  };
}

enum PropCode { FP201019133, FP190729045 }

final propCodeValues = EnumValues({
  "FP190729045": PropCode.FP190729045,
  "FP201019133": PropCode.FP201019133
});

enum PropertyIdTitle { PRAKRUTI_VIHAR, DWARAKA_NIWAS }

final propertyIdTitleValues = EnumValues({
  "Dwaraka Niwas": PropertyIdTitle.DWARAKA_NIWAS,
  "Prakruti Vihar": PropertyIdTitle.PRAKRUTI_VIHAR
});

enum RmSupport { YES, NO }

final rmSupportValues = EnumValues({
  "No": RmSupport.NO,
  "Yes": RmSupport.YES
});

enum Salaried { NOT_SALARIED }

final salariedValues = EnumValues({
  "Not Salaried": Salaried.NOT_SALARIED
});

class Tracking {
  Tracking({
    this.date,
    this.track,
  });

  Date date;
  List<Track> track;

  factory Tracking.fromJson(Map<String, dynamic> json) => Tracking(
    date: dateValues.map[json["date"]],
    track: List<Track>.from(json["track"].map((x) => Track.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": dateValues.reverse[date],
    "track": List<dynamic>.from(track.map((x) => x.toJson())),
  };
}

enum Date { THE_16_NOV_20, THE_15_NOV_20, THE_13_NOV_20, THE_12_NOV_20, THE_11_NOV_20, THE_09_NOV_20, THE_08_NOV_20 }

final dateValues = EnumValues({
  "08 Nov, 20": Date.THE_08_NOV_20,
  "09 Nov, 20": Date.THE_09_NOV_20,
  "11 Nov, 20": Date.THE_11_NOV_20,
  "12 Nov, 20": Date.THE_12_NOV_20,
  "13 Nov, 20": Date.THE_13_NOV_20,
  "15 Nov, 20": Date.THE_15_NOV_20,
  "16 Nov, 20": Date.THE_16_NOV_20
});

class Track {
  Track({
    this.id,
    this.title,
    this.description,
    this.time,
  });

  String id;
  TrackTitle title;
  String description;
  String time;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
    id: json["id"],
    title: trackTitleValues.map[json["title"]],
    description: json["description"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": trackTitleValues.reverse[title],
    "description": description,
    "time": time,
  };
}

enum TrackTitle { LEAD_FOLLOWUP, RELATIONSHIP_MANAGER, LEAD_DISQUALIFIED, LEAD_INTERESTED, LEAD_UNDER_FOLLOWUP, LEAD_UNDER_REVIEW, LEED_FOLLOW_UP, TITLE_LEAD_INTERESTED }

final trackTitleValues = EnumValues({
  "LEAD DISQUALIFIED": TrackTitle.LEAD_DISQUALIFIED,
  "LEAD FOLLOWUP": TrackTitle.LEAD_FOLLOWUP,
  "LEAD INTERESTED": TrackTitle.LEAD_INTERESTED,
  "LEAD UNDER FOLLOWUP": TrackTitle.LEAD_UNDER_FOLLOWUP,
  "LEAD UNDER REVIEW": TrackTitle.LEAD_UNDER_REVIEW,
  "LEED FOLLOW-UP": TrackTitle.LEED_FOLLOW_UP,
  "Relationship Manager": TrackTitle.RELATIONSHIP_MANAGER,
  "Lead Interested": TrackTitle.TITLE_LEAD_INTERESTED
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