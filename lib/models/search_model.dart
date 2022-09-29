class SearchModel
{
   bool? status;
   FavoritesDataModel? data;
  SearchModel.formJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = FavoritesDataModel.formJson(json['data']);
  }
}

class FavoritesDataModel {
   List<Product> data = [];
  FavoritesDataModel.formJson(Map<String, dynamic> json)
  {
    print('${json[data]}');
    json['data'].forEach((element) {
      data.add(Product.formJson(element));
    });

  }

}


class Product {
   int? id;
   dynamic? price;
   dynamic? oldPrice;
   int? discount;
   String? image;
   String? name;
   String? description;
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