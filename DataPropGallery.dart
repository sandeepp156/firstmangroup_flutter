class DataPropGallery {
    DataPropGallery({
        this.id,
        this.views,
        this.trending,
        this.featured,
        this.luxury,
        this.budget,
        this.title,
        this.propCode,
        this.city,
        this.area,
        this.location,
        this.latitude,
        this.longitude,
        this.possession,
        this.age,
        this.stage,
        this.contactName,
        this.contactPhone,
        this.commission,
        this.type,
        this.loan,
        this.constructionCompany,
        this.bhkStr,
        this.floors,
        this.unitsLeft,
        this.priceDisp,
        this.areaDisp,
        this.category,
        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.image5,
        this.image6,
        this.image7,
        this.image8,
        this.image9,
        this.file,
        this.date,
        this.description,
        this.amenities,
        this.flats,
        this.ratings,
    });

    String id;
    String views;
    String trending;
    String featured;
    String luxury;
    String budget;
    String title;
    String propCode;
    City city;
    Area area;
    String location;
    String latitude;
    String longitude;
    String possession;
    String age;
    String stage;
    String contactName;
    String contactPhone;
    String commission;
    String type;
    String loan;
    String constructionCompany;
    String bhkStr;
    String floors;
    String unitsLeft;
    String priceDisp;
    String areaDisp;
    Category category;
    String image1;
    String image2;
    String image3;
    String image4;
    String image5;
    String image6;
    String image7;
    String image8;
    String image9;
    String file;
    String date;
    String description;
    List<dynamic> amenities;
    List<Flat> flats;
    Ratings ratings;

    factory DataPropGallery.fromJson(Map<String, dynamic> json) => DataPropGallery(
        id: json["id"],
        views: json["views"],
        trending: json["trending"],
        featured: json["featured"],
        luxury: json["luxury"],
        budget: json["budget"],
        title: json["title"],
        propCode: json["prop_code"],
        city: City.fromJson(json["city"]),
        area: Area.fromJson(json["area"]),
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        possession: json["possession"],
        age: json["age"],
        stage: json["stage"],
        contactName: json["contact_name"],
        contactPhone: json["contact_phone"],
        commission: json["commission"],
        type: json["type"],
        loan: json["loan"],
        constructionCompany: json["construction_company"],
        bhkStr: json["bhk_str"],
        floors: json["floors"],
        unitsLeft: json["units_left"],
        priceDisp: json["price_disp"],
        areaDisp: json["area_disp"],
        category: Category.fromJson(json["category"]),
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        image4: json["image4"],
        image5: json["image5"],
        image6: json["image6"],
        image7: json["image7"],
        image8: json["image8"],
        image9: json["image9"],
        file: json["file"],
        date: json["date"],
        description: json["description"],
        amenities: List<dynamic>.from(json["amenities"].map((x) => x)),
        flats: List<Flat>.from(json["flats"].map((x) => Flat.fromJson(x))),
        ratings: Ratings.fromJson(json["ratings"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "views": views,
        "trending": trending,
        "featured": featured,
        "luxury": luxury,
        "budget": budget,
        "title": title,
        "prop_code": propCode,
        "city": city.toJson(),
        "area": area.toJson(),
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "possession": possession,
        "age": age,
        "stage": stage,
        "contact_name": contactName,
        "contact_phone": contactPhone,
        "commission": commission,
        "type": type,
        "loan": loan,
        "construction_company": constructionCompany,
        "bhk_str": bhkStr,
        "floors": floors,
        "units_left": unitsLeft,
        "price_disp": priceDisp,
        "area_disp": areaDisp,
        "category": category.toJson(),
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "image4": image4,
        "image5": image5,
        "image6": image6,
        "image7": image7,
        "image8": image8,
        "image9": image9,
        "file": file,
        "date": date,
        "description": description,
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "flats": List<dynamic>.from(flats.map((x) => x.toJson())),
        "ratings": ratings.toJson(),
    };
}

class Area {
    Area({
        this.areaId,
        this.title,
    });

    String areaId;
    String title;

    factory Area.fromJson(Map<String, dynamic> json) => Area(
        areaId: json["area_id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "area_id": areaId,
        "title": title,
    };
}

class Category {
    Category({
        this.categoryId,
        this.title,
    });

    String categoryId;
    String title;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "title": title,
    };
}

class City {
    City({
        this.cityId,
        this.title,
    });

    String cityId;
    String title;

    factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["city_id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "title": title,
    };
}

class Flat {
    Flat({
        this.flatId,
        this.title,
        this.area,
        this.type,
        this.price,
        this.finalPrice,
        this.facing,
        this.bathrooms,
        this.parking,
        this.description,
        this.image,
    });

    String flatId;
    String title;
    String area;
    String type;
    String price;
    String finalPrice;
    String facing;
    String bathrooms;
    String parking;
    String description;
    String image;

    factory Flat.fromJson(Map<String, dynamic> json) => Flat(
        flatId: json["flat_id"],
        title: json["title"],
        area: json["area"],
        type: json["type"],
        price: json["price"],
        finalPrice: json["final_price"],
        facing: json["facing"],
        bathrooms: json["bathrooms"],
        parking: json["parking"],
        description: json["description"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "flat_id": flatId,
        "title": title,
        "area": area,
        "type": type,
        "price": price,
        "final_price": finalPrice,
        "facing": facing,
        "bathrooms": bathrooms,
        "parking": parking,
        "description": description,
        "image": image,
    };
}

class Ratings {
    Ratings({
        this.rating1,
        this.rating2,
        this.rating3,
        this.rating4,
    });

    String rating1;
    String rating2;
    String rating3;
    String rating4;

    factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        rating1: json["rating1"],
        rating2: json["rating2"],
        rating3: json["rating3"],
        rating4: json["rating4"],
    );

    Map<String, dynamic> toJson() => {
        "rating1": rating1,
        "rating2": rating2,
        "rating3": rating3,
        "rating4": rating4,
    };
}