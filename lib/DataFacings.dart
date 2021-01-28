class DataFacings {
    String id;
    String title;

    DataFacings({this.id, this.title});

    factory DataFacings.fromJson(Map<String, dynamic> json) {
        return DataFacings(
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