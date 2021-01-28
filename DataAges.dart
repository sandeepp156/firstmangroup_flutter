class DataAges {
    String id;
    String title;

    DataAges({this.id, this.title});

    factory DataAges.fromJson(Map<String, dynamic> json) {
        return DataAges(
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