class SubCategories {
  int? id;
  int? parentId;
  int? categoryType;
  String? name;

  SubCategories({this.id, this.parentId, this.categoryType, this.name});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    categoryType = json['category_type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['category_type'] = this.categoryType;
    data['name'] = this.name;
    return data;
  }
}