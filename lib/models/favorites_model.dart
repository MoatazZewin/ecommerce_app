class FavoritesModel
{
  late bool status;
  late FavoritesDataModel data;
  FavoritesModel.formJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = FavoritesDataModel.formJson(json['data']);
  }
}

class FavoritesDataModel {
  List<Data> data = [];
  FavoritesDataModel.formJson(Map<String, dynamic> json)
  {
    print('${json[data]}');
    json['data'].forEach((element) {
      data.add(Data.formJson(element));
    });

  }

}

class Data {
  late Product product;
  Data.formJson(Map<String, dynamic> json)
  {
    product = Product.formJson(json['product']);

  }


}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;
  Product.formJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}