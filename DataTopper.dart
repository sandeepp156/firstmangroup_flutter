class DataToppers {
    String id;
    String member_code;
    String name;

    DataToppers({this.id, this.member_code, this.name});

    factory DataToppers.fromJson(Map<String, dynamic> json) {
        return DataToppers(
            id: json['id'], 
            member_code: json['member_code'], 
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['member_code'] = this.member_code;
        data['name'] = this.name;
        return data;
    }
}