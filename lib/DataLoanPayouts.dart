class DataLoanPayouts {
    List<DirectCommission> direct_commissions;
    List<DirectCommissionsGraph> direct_commissions_graph;
    String direct_commissions_total;
    String direct_commissions_total_paid;
    String direct_commissions_total_pending;
    List<OverrideCommission> override_commissions;
    List<OverrideCommissionsGraph> override_commissions_graph;
    String override_commissions_total;
    String override_commissions_total_paid;
    String override_commissions_total_pending;

    DataLoanPayouts({this.direct_commissions, this.direct_commissions_graph, this.direct_commissions_total, this.direct_commissions_total_paid, this.direct_commissions_total_pending, this.override_commissions, this.override_commissions_graph, this.override_commissions_total, this.override_commissions_total_paid, this.override_commissions_total_pending});

    factory DataLoanPayouts.fromJson(Map<String, dynamic> json) {
        return DataLoanPayouts(
            direct_commissions: json['direct_commissions'] != null ? (json['direct_commissions'] as List).map((i) => DirectCommission.fromJson(i)).toList() : null, 
            direct_commissions_graph: json['direct_commissions_graph'] != null ? (json['direct_commissions_graph'] as List).map((i) => DirectCommissionsGraph.fromJson(i)).toList() : null, 
            direct_commissions_total: json['direct_commissions_total'], 
            direct_commissions_total_paid: json['direct_commissions_total_paid'], 
            direct_commissions_total_pending: json['direct_commissions_total_pending'], 
            override_commissions: json['override_commissions'] != null ? (json['override_commissions'] as List).map((i) => OverrideCommission.fromJson(i)).toList() : null, 
            override_commissions_graph: json['override_commissions_graph'] != null ? (json['override_commissions_graph'] as List).map((i) => OverrideCommissionsGraph.fromJson(i)).toList() : null, 
            override_commissions_total: json['override_commissions_total'], 
            override_commissions_total_paid: json['override_commissions_total_paid'], 
            override_commissions_total_pending: json['override_commissions_total_pending'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['direct_commissions_total'] = this.direct_commissions_total;
        data['direct_commissions_total_paid'] = this.direct_commissions_total_paid;
        data['direct_commissions_total_pending'] = this.direct_commissions_total_pending;
        data['override_commissions_total'] = this.override_commissions_total;
        data['override_commissions_total_paid'] = this.override_commissions_total_paid;
        data['override_commissions_total_pending'] = this.override_commissions_total_pending;
        if (this.direct_commissions != null) {
            data['direct_commissions'] = this.direct_commissions.map((v) => v.toJson()).toList();
        }
        if (this.direct_commissions_graph != null) {
            data['direct_commissions_graph'] = this.direct_commissions_graph.map((v) => v.toJson()).toList();
        }
        if (this.override_commissions != null) {
            data['override_commissions'] = this.override_commissions.map((v) => v.toJson()).toList();
        }
        if (this.override_commissions_graph != null) {
            data['override_commissions_graph'] = this.override_commissions_graph.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class OverrideCommissionsGraph {
    int count;
    String date;
    int total;
    String total_view;

    OverrideCommissionsGraph({this.count, this.date, this.total, this.total_view});

    factory OverrideCommissionsGraph.fromJson(Map<String, dynamic> json) {
        return OverrideCommissionsGraph(
            count: json['count'], 
            date: json['date'], 
            total: json['total'], 
            total_view: json['total_view'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['count'] = this.count;
        data['date'] = this.date;
        data['total'] = this.total;
        data['total_view'] = this.total_view;
        return data;
    }
}

class DirectCommissionsGraph {
    int count;
    String date;
    int total;
    String total_view;

    DirectCommissionsGraph({this.count, this.date, this.total, this.total_view});

    factory DirectCommissionsGraph.fromJson(Map<String, dynamic> json) {
        return DirectCommissionsGraph(
            count: json['count'], 
            date: json['date'], 
            total: json['total'], 
            total_view: json['total_view'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['count'] = this.count;
        data['date'] = this.date;
        data['total'] = this.total;
        data['total_view'] = this.total_view;
        return data;
    }
}

class OverrideCommission {
    String commission;
    String date;
    String id;
    String lead_id;
    int payable_amount;
    String status;
    String tds;
    String tp;
    String visits;

    OverrideCommission({this.commission, this.date, this.id, this.lead_id, this.payable_amount, this.status, this.tds, this.tp, this.visits});

    factory OverrideCommission.fromJson(Map<String, dynamic> json) {
        return OverrideCommission(
            commission: json['commission'], 
            date: json['date'], 
            id: json['id'], 
            lead_id: json['lead_id'], 
            payable_amount: json['payable_amount'], 
            status: json['status'], 
            tds: json['tds'], 
            tp: json['tp'], 
            visits: json['visits'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['commission'] = this.commission;
        data['date'] = this.date;
        data['id'] = this.id;
        data['lead_id'] = this.lead_id;
        data['payable_amount'] = this.payable_amount;
        data['status'] = this.status;
        data['tds'] = this.tds;
        data['tp'] = this.tp;
        data['visits'] = this.visits;
        return data;
    }
}

class DirectCommission {
    String commission;
    String date;
    String id;
    String lead_id;
    int payable_amount;
    String status;
    String tds;
    String tp;
    String visits;

    DirectCommission({this.commission, this.date, this.id, this.lead_id, this.payable_amount, this.status, this.tds, this.tp, this.visits});

    factory DirectCommission.fromJson(Map<String, dynamic> json) {
        return DirectCommission(
            commission: json['commission'], 
            date: json['date'], 
            id: json['id'], 
            lead_id: json['lead_id'], 
            payable_amount: json['payable_amount'], 
            status: json['status'], 
            tds: json['tds'], 
            tp: json['tp'], 
            visits: json['visits'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['commission'] = this.commission;
        data['date'] = this.date;
        data['id'] = this.id;
        data['lead_id'] = this.lead_id;
        data['payable_amount'] = this.payable_amount;
        data['status'] = this.status;
        data['tds'] = this.tds;
        data['tp'] = this.tp;
        data['visits'] = this.visits;
        return data;
    }
}