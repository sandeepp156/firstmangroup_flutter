class DataCategory {

  String id;
  String title;

  DataCategory({
    this.id,
    this.title,
  });


  factory DataCategory.fromJson(Map<String, dynamic> json) => DataCategory(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}