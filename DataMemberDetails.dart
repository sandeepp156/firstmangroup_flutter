class DataMemberDetails {
    String aadhar;
    String address;
    String bank;
    String cheque;
    String code;
    String cur_status;
    String email;
    String fname;
    String id;
    String image;
    String insurance_commission;
    String invite_ba_share;
    String kyc;
    String kyc_image;
    String lname;
    String loan_commission;
    String pancard;
    String phone;
    String profession;
    String questions;
    String realestate_commission;
    String realestate_manual_commission;
    String referred_by_code;
    RelationManager relation_manager;
    String total_commission;
    String type;
    String type_title;

    DataMemberDetails({this.aadhar, this.address, this.bank, this.cheque, this.code, this.cur_status, this.email, this.fname, this.id, this.image, this.insurance_commission, this.invite_ba_share, this.kyc, this.kyc_image, this.lname, this.loan_commission, this.pancard, this.phone, this.profession, this.questions, this.realestate_commission, this.realestate_manual_commission, this.referred_by_code, this.relation_manager, this.total_commission,this.type,this.type_title});

    factory DataMemberDetails.fromJson(Map<String, dynamic> json) {
        return DataMemberDetails(
            aadhar: json['aadhar'],
            address: json['address'],
            bank: json['bank'],
            cheque: json['cheque'],
            code: json['code'],
            cur_status: json['cur_status'],
            email: json['email'],
            fname: json['fname'],
            id: json['id'],
            image: json['image'],
            insurance_commission: json['insurance_commission'],
            invite_ba_share: json['invite_ba_share'],
            kyc: json['kyc'],
            kyc_image: json['kyc_image'],
            lname: json['lname'],
            loan_commission: json['loan_commission'],
            pancard: json['pancard'],
            phone: json['phone'],
            profession: json['profession'],
            questions: json['questions'],
            realestate_commission: json['realestate_commission'],
            realestate_manual_commission: json['realestate_manual_commission'],
            referred_by_code: json['referred_by_code'],
            relation_manager: json['relation_manager'] != null ? RelationManager.fromJson(json['relation_manager']) : null,
            total_commission: json['total_commission'],
            type: json['type'],
            type_title: json['type_title'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['aadhar'] = this.aadhar;
        data['address'] = this.address;
        data['bank'] = this.bank;
        data['cheque'] = this.cheque;
        data['code'] = this.code;
        data['cur_status'] = this.cur_status;
        data['email'] = this.email;
        data['fname'] = this.fname;
        data['id'] = this.id;
        data['image'] = this.image;
        data['insurance_commission'] = this.insurance_commission;
        data['invite_ba_share'] = this.invite_ba_share;
        data['kyc'] = this.kyc;
        data['kyc_image'] = this.kyc_image;
        data['lname'] = this.lname;
        data['loan_commission'] = this.loan_commission;
        data['pancard'] = this.pancard;
        data['phone'] = this.phone;
        data['profession'] = this.profession;
        data['questions'] = this.questions;
        data['realestate_commission'] = this.realestate_commission;
        data['realestate_manual_commission'] = this.realestate_manual_commission;
        data['referred_by_code'] = this.referred_by_code;
        data['total_commission'] = this.total_commission;
        data['type'] = this.type;
        data['type_title'] = this.type_title;
        if (this.relation_manager != null) {
            data['relation_manager'] = this.relation_manager.toJson();
        }
        return data;
    }
}

class RelationManager {
    String description;
    String email;
    String fname;
    String id;
    String image;
    String lname;
    String phone;

    RelationManager({this.description, this.email, this.fname, this.id, this.image, this.lname, this.phone});

    factory RelationManager.fromJson(Map<String, dynamic> json) {
        return RelationManager(
            description: json['description'],
            email: json['email'],
            fname: json['fname'],
            id: json['id'],
            image: json['image'],
            lname: json['lname'],
            phone: json['phone'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['description'] = this.description;
        data['email'] = this.email;
        data['fname'] = this.fname;
        data['id'] = this.id;
        data['image'] = this.image;
        data['lname'] = this.lname;
        data['phone'] = this.phone;
        return data;
    }
}