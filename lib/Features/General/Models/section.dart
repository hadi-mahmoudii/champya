import 'package:champya/Features/Program/Models/category-overview.dart';
// import 'package:champya/Features/Program/Models/workout-overview.dart';

import '../../../Core/Models/global.dart';
// import '../../Product/Models/product.dart';
import '../../Program/Models/program-overview.dart';

class HomeSectionModel {
  final String id, title, subTitle, type, sort, page;
  final List sections;

  HomeSectionModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.type,
    required this.sort,
    required this.page,
    required this.sections,
  });

  factory HomeSectionModel.fromJson(Map datas) {
    // log(datas.toString());
    List sections = [];
    final String type = GlobalEntity.dataFilter(datas['model_type'].toString());
    datas['items'].forEach((element) {
      switch (type) {
        case 'workout':
          // sections.add(WorkoutOverviewModel.fromJson(element));
          break;
        case 'course':
          sections.add(ProgramOverviewModel.fromHome(element));
          break;
        case 'product':
          // sections.add(ProductModel.fromJson(element));
          break;
        case 'sport_category':
          sections.add(CategoryOverviewModel.fromJson(element));
          break;
        default:
          sections.add(ProgramOverviewModel.fromHome(element));
      }
    });

    return HomeSectionModel(
      id: GlobalEntity.dataFilter(datas['category'].toString()),
      title: GlobalEntity.dataFilter(datas['title'].toString()),
      subTitle: GlobalEntity.dataFilter(datas['sub_title'].toString()),
      type: type,
      sort: GlobalEntity.dataFilter(datas['sort'].toString(), replacement: '0'),
      page: GlobalEntity.dataFilter(datas['page'].toString()),
      sections: sections,
    );
  }
}

// class SectionModel {
//   final String id, modelId, category, title, type, page;
//   final modelData;
//   // final int sort;
//   SectionModel({
//     required this.id,
//     required this.modelId,
//     required this.category,
//     required this.title,
//     required this.type,
//     required this.page,
//     required this.modelData,
//     // required this.sort,
//   });

//   factory SectionModel.fromJson(Map datas) {
//     var modelData;
//     final String type = GlobalEntity.dataFilter(datas['model_type'].toString());
//     switch (type) {
//       case 'course':
//         modelData = ProgramOverviewModel.fromHome(datas);
//         break;
//       case 'product':
//         modelData = ProductModel.fromJson(datas);
//         break;
//       case 'workout':
//         modelData = WorkoutOverviewModel.fromJson(datas);
//         break;
//       default:
//     }
//     return SectionModel(
//       id: GlobalEntity.dataFilter(datas['id'].toString()),
//       modelId: GlobalEntity.dataFilter(datas['model_id'].toString()),
//       category: GlobalEntity.dataFilter(datas['category'].toString()),
//       title: GlobalEntity.dataFilter(datas['title'].toString()),
//       type: type,
//       page: GlobalEntity.dataFilter(datas['page'].toString()),
//       modelData: modelData,
//       // sort: datas['sort'],
//     );
//   }
// }
