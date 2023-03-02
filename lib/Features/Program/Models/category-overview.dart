import '../../../Core/Models/global.dart';

class CategoryOverviewModel {
  final String id, name, title, image;

  CategoryOverviewModel({
    required this.id,
    required this.name,
    required this.title,
    required this.image,
  });

  factory CategoryOverviewModel.fromJson(Map? datas) {
    // log(datas.toString());
    // for (var item in datas!.keys) {
    //   print(item);
    // }
    return CategoryOverviewModel(
      id: GlobalEntity.dataFilter(datas!['id']),
      name: GlobalEntity.dataFilter(datas['name']),
      title: GlobalEntity.dataFilter(datas['title']),
      image: GlobalEntity.dataFilter(datas['static_image']),
    );
  }
}
