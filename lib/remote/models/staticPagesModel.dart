class StaticPagesModel {
  int? id;
  String? pageName;
  String? content;
  String? photo;

  StaticPagesModel({this.id, this.pageName, this.content, this.photo});

  StaticPagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageName = json['page_name'];
    content = json['content'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['page_name'] = this.pageName;
    data['content'] = this.content;
    data['photo'] = this.photo;
    return data;
  }
}