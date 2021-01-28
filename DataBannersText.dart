class DataBannersText {
    String big_description;
    String description;
    String id;
    String image;
    String link;
    String title;

    DataBannersText({this.big_description, this.description, this.id, this.image, this.link, this.title});

    factory DataBannersText.fromJson(Map<String, dynamic> json) {
        return DataBannersText(
            big_description: json['big_description'], 
            description: json['description'], 
            id: json['id'], 
            image: json['image'], 
            link: json['link'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['big_description'] = this.big_description;
        data['description'] = this.description;
        data['id'] = this.id;
        data['image'] = this.image;
        data['link'] = this.link;
        data['title'] = this.title;
        return data;
    }
}