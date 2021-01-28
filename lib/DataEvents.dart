class DataEvents {
    City city;
    String conclude_date;
    String description;
    String end_time;
    String id;
    String image;
    String launch_date;
    String start_time;
    String title;
    String venue;
    String venue_address;
    String venue_image;

    DataEvents({this.city, this.conclude_date, this.description, this.end_time, this.id, this.image, this.launch_date, this.start_time, this.title, this.venue, this.venue_address, this.venue_image});

    factory DataEvents.fromJson(Map<String, dynamic> json) {
        return DataEvents(
            city: json['city'] != null ? City.fromJson(json['city']) : null, 
            conclude_date: json['conclude_date'], 
            description: json['description'], 
            end_time: json['end_time'], 
            id: json['id'], 
            image: json['image'], 
            launch_date: json['launch_date'], 
            start_time: json['start_time'], 
            title: json['title'], 
            venue: json['venue'], 
            venue_address: json['venue_address'], 
            venue_image: json['venue_image'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['conclude_date'] = this.conclude_date;
        data['description'] = this.description;
        data['end_time'] = this.end_time;
        data['id'] = this.id;
        data['image'] = this.image;
        data['launch_date'] = this.launch_date;
        data['start_time'] = this.start_time;
        data['title'] = this.title;
        data['venue'] = this.venue;
        data['venue_address'] = this.venue_address;
        data['venue_image'] = this.venue_image;
        if (this.city != null) {
            data['city'] = this.city.toJson();
        }
        return data;
    }
}

class City {
    String id;
    String title;

    City({this.id, this.title});

    factory City.fromJson(Map<String, dynamic> json) {
        return City(
            id: json['id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['title'] = this.title;
        return data;
    }
}