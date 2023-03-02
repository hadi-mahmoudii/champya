import '../../../Core/Models/global.dart';

class ProductModel {
  final String id, name, title, description;
  final String image, buyLink;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.image,
    required this.buyLink,
    required this.images,
  });

  factory ProductModel.fromJson(Map? datas) {
    List<String> images = [];
    try {
      for (var item in datas!['images']) {
        images.add(item['thumbnail']);
      }
    } catch (e) {}
    // log(datas.toString());

    return ProductModel(
      id: GlobalEntity.dataFilter(datas!['id']),
      name: GlobalEntity.dataFilter(datas['name']),
      title: GlobalEntity.dataFilter(datas['title']),
      description: GlobalEntity.dataFilter(datas['description']),
      image: GlobalEntity.dataFilter(datas['thumbnail']),
      buyLink: GlobalEntity.dataFilter(datas['purchase_link']),
      images: images,
    );
  }
}

// class ProductModel {
//   final String? id, categoryId, name, eName, description;
//   final bool? available, isNumbericType, letTextOnItem, letTextAroundItem;
//   final String? priceN, priceK, discount;
//   final String? amount, count;
//   final double? rate;

//   ProductModel({
//     @required this.id,
//     @required this.categoryId,
//     @required this.name,
//     @required this.eName,
//     @required this.description,
//     @required this.available,
//     @required this.letTextOnItem,
//     @required this.letTextAroundItem,
//     @required this.isNumbericType,
//     @required this.priceN,
//     @required this.priceK,
//     @required this.amount,
//     @required this.count,
//     @required this.discount,
//     @required this.rate,
//   });

//   factory ProductModel.fromJson(Map? datas) {
//     bool isNumbericType = false;
//     String priceN = '';
//     String priceK = '';

//     try {
//       if (GlobalEntity.dataFilter(datas!['price_number']) != '')
//         isNumbericType = true;
//     } catch (e) {}

//     // for (var ky in datas!.keys) {
//     // print(ky);
//     // }

//     double rate = 0;
//     try {
//       rate = double.parse(GlobalEntity.dataFilter(datas!['rate']));
//     } catch (e) {}
//     return ProductModel(
//       id: GlobalEntity.dataFilter(datas!['id']),
//       categoryId: GlobalEntity.dataFilter(datas['category_id']),
//       name: GlobalEntity.dataFilter(datas['name']),
//       eName: GlobalEntity.dataFilter(datas['name_en']),
//       description: GlobalEntity.dataFilter(datas['description']),
//       available: datas['available'],
//       letTextOnItem: datas['text_on_item'],
//       letTextAroundItem: datas['text_around_item'],
//       isNumbericType: isNumbericType,
//       priceN: priceN,
//       priceK: priceK,
//       amount: GlobalEntity.dataFilter(datas['amount']),
//       count: GlobalEntity.dataFilter(datas['count']),
//       discount: GlobalEntity.dataFilter(datas['price_discounted']),
//       rate: rate,
//     );
//   }
// }
