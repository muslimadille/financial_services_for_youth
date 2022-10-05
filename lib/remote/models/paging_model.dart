class pagerModel {
  int? currentPage;
  List<ProviderModel>? data;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;

  pagerModel(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to});

  pagerModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ProviderModel>[];
      json['data'].forEach((v) {
        data!.add(new ProviderModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    return data;
  }
}

class ProviderModel {
  int? id;
  String? name;
  int? categoryId;
  int? subCategoryId;
  String? government;
  String? city;
  String? address;
  String? phone;
  String? whatsapp;
  String? website;
  String? email;
  String? location;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<GetFeatures>? getFeatures;

  ProviderModel(
      {this.id,
        this.name,
        this.categoryId,
        this.subCategoryId,
        this.government,
        this.city,
        this.address,
        this.phone,
        this.whatsapp,
        this.website,
        this.email,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.getFeatures});

  ProviderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    government = json['government'];
    city = json['city'];
    address = json['address'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    website = json['website'];
    email = json['email'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['get_features'] != null) {
      getFeatures = <GetFeatures>[];
      json['get_features'].forEach((v) {
        getFeatures!.add(new GetFeatures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['government'] = this.government;
    data['city'] = this.city;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    data['website'] = this.website;
    data['email'] = this.email;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.getFeatures != null) {
      data['get_features'] = this.getFeatures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetFeatures {
  int? id;
  String? key;
  String? value;
  int? ProviderModelId;

  GetFeatures({this.id, this.key, this.value, this.ProviderModelId});

  GetFeatures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    ProviderModelId = json['ProviderModel_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    data['ProviderModel_id'] = this.ProviderModelId;
    return data;
  }
}


