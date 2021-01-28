
class Cart{
  final String id;
  final String title;
  final String price;
  final String image;
  final String views;
  final String address;
  final String quantity;


  Cart({this.id, this.title, this.price,this.quantity,this.views,this.image,this.address});

  factory Cart.fromJson(Map<String, dynamic> json){
    return Cart(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      address: json['address'],
      views: json['views'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['title']=this.title;
    data['price']=this.price;
    data['address']=this.address;
    data['image']=this.image;
    data['views']=this.views;
    data['quantity']=this.quantity;
    return data;
  }
}