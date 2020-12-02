class DataLoanDetails {
    String id;
    String image;
    List<Loan> loans;
    String title;

    DataLoanDetails({this.id, this.image, this.loans, this.title});

    factory DataLoanDetails.fromJson(Map<String, dynamic> json) {
        return DataLoanDetails(
            id: json['id'], 
            image: json['image'], 
            loans: json['loans'] != null ? (json['loans'] as List).map((i) => Loan.fromJson(i)).toList() : null, 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['image'] = this.image;
        data['title'] = this.title;
        if (this.loans != null) {
            data['loans'] = this.loans.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Loan {
    String loan_id;
    String loan_title;
    String roi;

    Loan({this.loan_id, this.loan_title, this.roi});

    factory Loan.fromJson(Map<String, dynamic> json) {
        return Loan(
            loan_id: json['loan_id'], 
            loan_title: json['loan_title'], 
            roi: json['roi'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['loan_id'] = this.loan_id;
        data['loan_title'] = this.loan_title;
        data['roi'] = this.roi;
        return data;
    }
}