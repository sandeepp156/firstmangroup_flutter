class DataFurnished {
    String id;
    String title;

    DataFurnished({this.id, this.title});

    factory DataFurnished.fromJson(Map<String, dynamic> json) {
        return DataFurnished(
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