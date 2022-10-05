import 'package:services_app/remote/models/subcategory_model.dart';
class Categories{
  int? id;
  int? parentId;
  int? categoryType;
  String? name;
  List<SubCategories>? subCategories;

  Categories(
      {this.id,
        this.parentId,
        this.categoryType,
        this.name,
        this.subCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    categoryType = json['category_type'];
    name = json['name'];
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['category_type'] = this.categoryType;
    data['name'] = this.name;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class CategoryModel {
  bool? app_status;
  List<Categories>? categories;
  CategoryModel({this.app_status, this.categories,});
  CategoryModel.fromJson(Map<String, dynamic> json) {
    app_status = json['app_status'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['app_status'] = this.app_status;
    if (this.categories != null) {
      data['categories'] =
          this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

