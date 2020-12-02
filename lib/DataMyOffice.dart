class DataMyOffice {
    String file;
    String age;
    List<Amenity> amenities;
    Area area;
    String area_disp;
    String bhk_str;
    String budget;
    Category category;
    City city;
    String commission;
    String commission_view;
    String construction_company;
    String contact_name;
    String contact_phone;
    String date;
    String description;
    String expiry_date;
    String featured;
    List<Flat> flats;
    String floors;
    String id;
    String image1;
    String image2;
    String image3;
    String image4;
    String image5;
    String image6;
    String image7;
    String image8;
    String image9;
    String invoice_no;
    String latitude;
    String loan;
    String location;
    String longitude;
    String luxury;
    String offer_image;
    String possession;
    String price_disp;
    String prop_code;
    Ratings ratings;
    String stage;
    Subscription subscription;
    String subscription_amount;
    String subscription_date;
    String title;
    String trending;
    String type;
    String units_left;
    String video_link;
    String views;

    DataMyOffice({this.file, this.age, this.amenities, this.area, this.area_disp, this.bhk_str, this.budget, this.category, this.city, this.commission, this.commission_view, this.construction_company, this.contact_name, this.contact_phone, this.date, this.description, this.expiry_date, this.featured, this.flats, this.floors, this.id, this.image1, this.image2, this.image3, this.image4, this.image5, this.image6, this.image7, this.image8, this.image9, this.invoice_no, this.latitude, this.loan, this.location, this.longitude, this.luxury, this.offer_image, this.possession, this.price_disp, this.prop_code, this.ratings, this.stage, this.subscription, this.subscription_amount, this.subscription_date, this.title, this.trending, this.type, this.units_left, this.video_link, this.views});

    factory DataMyOffice.fromJson(Map<String, dynamic> json) {
        return DataMyOffice(
            file: json['file'],
            age: json['age'], 
            amenities: json['amenities'] != null ? (json['amenities'] as List).map((i) => Amenity.fromJson(i)).toList() : null, 
            area: json['area'] != null ? Area.fromJson(json['area']) : null, 
            area_disp: json['area_disp'], 
            bhk_str: json['bhk_str'], 
            budget: json['budget'], 
            category: json['category'] != null ? Category.fromJson(json['category']) : null, 
            city: json['city'] != null ? City.fromJson(json['city']) : null, 
            commission: json['commission'], 
            commission_view: json['commission_view'], 
            construction_company: json['construction_company'], 
            contact_name: json['contact_name'], 
            contact_phone: json['contact_phone'], 
            date: json['date'], 
            description: json['description'], 
            expiry_date: json['expiry_date'], 
            featured: json['featured'], 
            flats: json['flats'] != null ? (json['flats'] as List).map((i) => Flat.fromJson(i)).toList() : null, 
            floors: json['floors'], 
            id: json['id'], 
            image1: json['image1'], 
            image2: json['image2'], 
            image3: json['image3'], 
            image4: json['image4'], 
            image5: json['image5'], 
            image6: json['image6'], 
            image7: json['image7'], 
            image8: json['image8'], 
            image9: json['image9'], 
            invoice_no: json['invoice_no'], 
            latitude: json['latitude'], 
            loan: json['loan'], 
            location: json['location'], 
            longitude: json['longitude'], 
            luxury: json['luxury'], 
            offer_image: json['offer_image'], 
            possession: json['possession'], 
            price_disp: json['price_disp'], 
            prop_code: json['prop_code'], 
            ratings: json['ratings'] != null ? Ratings.fromJson(json['ratings']) : null, 
            stage: json['stage'], 
            subscription: json['subscription'] != null ? Subscription.fromJson(json['subscription']) : null, 
            subscription_amount: json['subscription_amount'], 
            subscription_date: json['subscription_date'], 
            title: json['title'], 
            trending: json['trending'], 
            type: json['type'], 
            units_left: json['units_left'], 
            video_link: json['video_link'], 
            views: json['views'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['file'] = this.file;
        data['age'] = this.age;
        data['area_disp'] = this.area_disp;
        data['bhk_str'] = this.bhk_str;
        data['budget'] = this.budget;
        data['commission'] = this.commission;
        data['commission_view'] = this.commission_view;
        data['construction_company'] = this.construction_company;
        data['contact_name'] = this.contact_name;
        data['contact_phone'] = this.contact_phone;
        data['date'] = this.date;
        data['description'] = this.description;
        data['expiry_date'] = this.expiry_date;
        data['featured'] = this.featured;
        data['floors'] = this.floors;
        data['id'] = this.id;
        data['image1'] = this.image1;
        data['image2'] = this.image2;
        data['image3'] = this.image3;
        data['image4'] = this.image4;
        data['image5'] = this.image5;
        data['image6'] = this.image6;
        data['image7'] = this.image7;
        data['image8'] = this.image8;
        data['image9'] = this.image9;
        data['invoice_no'] = this.invoice_no;
        data['latitude'] = this.latitude;
        data['loan'] = this.loan;
        data['location'] = this.location;
        data['longitude'] = this.longitude;
        data['luxury'] = this.luxury;
        data['offer_image'] = this.offer_image;
        data['possession'] = this.possession;
        data['price_disp'] = this.price_disp;
        data['prop_code'] = this.prop_code;
        data['stage'] = this.stage;
        data['subscription_amount'] = this.subscription_amount;
        data['subscription_date'] = this.subscription_date;
        data['title'] = this.title;
        data['trending'] = this.trending;
        data['type'] = this.type;
        data['units_left'] = this.units_left;
        data['video_link'] = this.video_link;
        data['views'] = this.views;
        if (this.amenities != null) {
            data['amenities'] = this.amenities.map((v) => v.toJson()).toList();
        }
        if (this.area != null) {
            data['area'] = this.area.toJson();
        }
        if (this.category != null) {
            data['category'] = this.category.toJson();
        }
        if (this.city != null) {
            data['city'] = this.city.toJson();
        }
        if (this.flats != null) {
            data['flats'] = this.flats.map((v) => v.toJson()).toList();
        }
        if (this.ratings != null) {
            data['ratings'] = this.ratings.toJson();
        }
        if (this.subscription != null) {
            data['subscription'] = this.subscription.toJson();
        }
        return data;
    }
}

class Amenity {
    List<AmenitiesValue> amenities_values;
    String cat_id;
    String title;

    Amenity({this.amenities_values, this.cat_id, this.title});

    factory Amenity.fromJson(Map<String, dynamic> json) {
        return Amenity(
            amenities_values: json['amenities_values'] != null ? (json['amenities_values'] as List).map((i) => AmenitiesValue.fromJson(i)).toList() : null, 
            cat_id: json['cat_id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cat_id'] = this.cat_id;
        data['title'] = this.title;
        if (this.amenities_values != null) {
            data['amenities_values'] = this.amenities_values.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class AmenitiesValue {
    String amenity_id;
    String image;
    String title;

    AmenitiesValue({this.amenity_id, this.image, this.title});

    factory AmenitiesValue.fromJson(Map<String, dynamic> json) {
        return AmenitiesValue(
            amenity_id: json['amenity_id'], 
            image: json['image'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amenity_id'] = this.amenity_id;
        data['image'] = this.image;
        data['title'] = this.title;
        return data;
    }
}

class City {
    String city_id;
    String title;

    City({this.city_id, this.title});

    factory City.fromJson(Map<String, dynamic> json) {
        return City(
            city_id: json['city_id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['city_id'] = this.city_id;
        data['title'] = this.title;
        return data;
    }
}

class Ratings {
    String rating1;
    String rating2;
    String rating3;
    String rating4;

    Ratings({this.rating1, this.rating2, this.rating3, this.rating4});

    factory Ratings.fromJson(Map<String, dynamic> json) {
        return Ratings(
            rating1: json['rating1'], 
            rating2: json['rating2'], 
            rating3: json['rating3'], 
            rating4: json['rating4'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['rating1'] = this.rating1;
        data['rating2'] = this.rating2;
        data['rating3'] = this.rating3;
        data['rating4'] = this.rating4;
        return data;
    }
}

class Category {
    String category_id;
    String title;

    Category({this.category_id, this.title});

    factory Category.fromJson(Map<String, dynamic> json) {
        return Category(
            category_id: json['category_id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['category_id'] = this.category_id;
        data['title'] = this.title;
        return data;
    }
}

class Subscription {
    String subscription_id;
    String title;

    Subscription({this.subscription_id, this.title});

    factory Subscription.fromJson(Map<String, dynamic> json) {
        return Subscription(
            subscription_id: json['subscription_id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['subscription_id'] = this.subscription_id;
        data['title'] = this.title;
        return data;
    }
}

class Area {
    String area_id;
    String title;

    Area({this.area_id, this.title});

    factory Area.fromJson(Map<String, dynamic> json) {
        return Area(
            area_id: json['area_id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['area_id'] = this.area_id;
        data['title'] = this.title;
        return data;
    }
}

class Flat {
    String area;
    String bathrooms;
    String description;
    String facing;
    String final_price;
    String flat_id;
    String image;
    String parking;
    String price;
    String title;
    String type;

    Flat({this.area, this.bathrooms, this.description, this.facing, this.final_price, this.flat_id, this.image, this.parking, this.price, this.title, this.type});

    factory Flat.fromJson(Map<String, dynamic> json) {
        return Flat(
            area: json['area'], 
            bathrooms: json['bathrooms'], 
            description: json['description'], 
            facing: json['facing'], 
            final_price: json['final_price'], 
            flat_id: json['flat_id'], 
            image: json['image'], 
            parking: json['parking'], 
            price: json['price'], 
            title: json['title'], 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['area'] = this.area;
        data['bathrooms'] = this.bathrooms;
        data['description'] = this.description;
        data['facing'] = this.facing;
        data['final_price'] = this.final_price;
        data['flat_id'] = this.flat_id;
        data['image'] = this.image;
        data['parking'] = this.parking;
        data['price'] = this.price;
        data['title'] = this.title;
        data['type'] = this.type;
        return data;
    }
}