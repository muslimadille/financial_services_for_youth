import 'dart:convert';
import '../remote/models/categoryModel.dart';
import '../remote/models/paging_model.dart';
import '../remote/models/staticPagesModel.dart';
import '../remote/my_responce.dart';
import '../remote/dio_utils.dart';
import '../utils/apis.dart';

class CategoryApi{
  Future<MyResponse<CategoryModel>> getCategories() async {
    final url = "${Apis.CATEGORIES_API}";
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_GET, url);
    if (response != null && response.statusCode == 200) {
      return MyResponse<CategoryModel>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<CategoryModel>.init(Apis.CODE_ERROR, "", null);
    }
  }
  Future<MyResponse<pagerModel>> getProviders(int categoryId,int subCategoryId,String government,int page) async {
    final url = "${Apis.PROVIDER_API}?category_id=$categoryId&sub_category_id=$subCategoryId&government=$government&page=$page";
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_GET, url);
    if (response != null && response.statusCode == 200) {
      return MyResponse<pagerModel>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<pagerModel>.init(Apis.CODE_ERROR, "", null);
    }
  }
  Future<MyResponse<List<StaticPagesModel>>> getStaticPages() async {
    final url = "${Apis.STATIC_PAGES_API}";
    final response = await BaseDioUtils.request(BaseDioUtils.REQUEST_GET, url);
    if (response != null && response.statusCode == 200) {
      return MyResponse<List<StaticPagesModel>>.fromJson(
          json.decode(jsonEncode(response.data)));
    } else {
      return MyResponse<List<StaticPagesModel>>.init(Apis.CODE_ERROR, "", null);
    }
  }
}