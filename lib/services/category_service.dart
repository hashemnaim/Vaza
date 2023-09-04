import 'package:faza_app/Module/home/category/model/category_model.dart';
import '../../helper/dio_helper.dart';
import '../../Module/home/category/model/trending_model.dart';

class CategoryService {
  static Future<CategoryModel> getCategory() async {
    var response = await DioHelper.getData("categories");
    final responseData = categoryModelFromJson(response.data);
    return responseData;
  }

  // static Future<SubCategoryModel> getSubCategory(id) async {
  //   var response = await DioHelper.getData("products-by-category/$id");
  //   final responseData = subCategoryModelFromJson(response.data);
  //   return responseData;
  // }

  static Future<CategoryModel> getBigCoverCategories() async {
    var response = await DioHelper.getData("big-cover-categories");
    final responseData = categoryModelFromJson(response.data);
    return responseData;
  }

  static Future<TrendingModel> getTraindgCategories() async {
    var response = await DioHelper.getData(
      "trending-categories",
    );
    final responseData = TrendingModel.fromJson(response.data);
    return responseData;
  }

  static Future<TrendingData> getTraindgSubCategories(String idCaogery) async {
    var response = await DioHelper.getData("trending-categories/$idCaogery");
    final responseData = TrendingData.fromJson(response.data['data']);
    return responseData;
  }
}
