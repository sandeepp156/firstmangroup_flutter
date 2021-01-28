class DataPackages {
    String duration;
    String id;
    String price;
    String title;

    DataPackages({this.duration, this.id, this.price, this.title});

    factory DataPackages.fromJson(Map<String, dynamic> json) {
        return DataPackages(
            duration: json['duration'], 
            id: json['id'], 
            price: json['price'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['duration'] = this.duration;
        data['id'] = this.id;
        data['price'] = this.price;
        data['title'] = this.title;
        return data;
    }
}