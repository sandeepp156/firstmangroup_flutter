class DataCities {
    String id;
    String image;
    String title;

    DataCities({this.id, this.image, this.title});

    factory DataCities.fromJson(Map<String, dynamic> json) {
        return DataCities(
            id: json['id'], 
            image: json['image'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['image'] = this.image;
        data['title'] = this.title;
        return data;
    }
}