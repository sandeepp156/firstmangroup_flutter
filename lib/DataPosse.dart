class DataPosse {
    String id;
    String title;

    DataPosse({this.id, this.title});

    factory DataPosse.fromJson(Map<String, dynamic> json) {
        return DataPosse(
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