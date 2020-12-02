class DataMyFms {
    String aadhar;
    String address;
    String code;
    int commission;
    String email;
    String fname;
    String id;
    String image;
    String lname;
    String phone;
    String profession;

    DataMyFms({this.aadhar, this.address, this.code, this.commission, this.email, this.fname, this.id, this.image, this.lname, this.phone, this.profession});

    factory DataMyFms.fromJson(Map<String, dynamic> json) {
        return DataMyFms(
            aadhar: json['aadhar'], 
            address: json['address'], 
            code: json['code'], 
            commission: json['commission'], 
            email: json['email'], 
            fname: json['fname'], 
            id: json['id'], 
            image: json['image'], 
            lname: json['lname'], 
            phone: json['phone'], 
            profession: json['profession'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['aadhar'] = this.aadhar;
        data['address'] = this.address;
        data['code'] = this.code;
        data['commission'] = this.commission;
        data['email'] = this.email;
        data['fname'] = this.fname;
        data['id'] = this.id;
        data['image'] = this.image;
        data['lname'] = this.lname;
        data['phone'] = this.phone;
        data['profession'] = this.profession;
        return data;
    }
}