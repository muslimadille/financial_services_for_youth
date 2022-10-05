import 'models/categoryModel.dart';
import '../remote/models/paging_model.dart';
import 'models/staticPagesModel.dart';


class MyResponse<T> extends Object {
  final TAG = "MyResponse";

  String? _status = "";
  String? _msg = "";
  var _data;
  int?_activation_code;

  MyResponse.fromJson(Map<String, dynamic> json) {
    print("$TAG: ${json.toString()}");
    if (json.containsKey("activation_code")) {
      _activation_code = json['activation_code'];
    }
    if (json.containsKey("status")) {
      _status = json['status'].toString();
    }
    if (json.containsKey("Error")) {
      _msg = json['Error'];
    } else if (json.containsKey("error")) {
      _msg = json['error'];
    }
    if (json.containsKey("message")) {
      _msg = json['message'];
    }
    if (json.containsKey("Data")) {
      if(_status=="400"){
        _data=null;
      }else{
        _checkType(json['Data']);
      }
    } else if (json.containsKey("data")) {
      if(_status=="400"){
        _data=null;
      }else{
        _checkType(json['data']);
      }    }


  }

  MyResponse.init(String status, String msg, dynamic data, {int? code}) {
    _status = status;
    _msg = msg;
    _activation_code=code;
    if (data is int) {
      _status = "$data";
    } else {
      _data = data;
    }

  }

  _checkType(json) {
    print("$TAG-T_Type: $T");

    if (json != null) {
      if (!_parseList(json)) {
        _parseSingle(json);
      }
    } else {
      _data = null;
    }
  }

  _parseSingle(json) {
    switch (T) {
      case pagerModel:
        _data = pagerModel.fromJson(json) as T;
        break;
      case CategoryModel:
        _data = CategoryModel.fromJson(json) as T;
        break;


      default:_data = null;
    }
  }

  bool _parseList(json) {
    if ("$T".contains("List<CategoryModel>")) {
      _data = (json as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList() as T;

    }else if ("$T".contains("List<ProviderModel>")) {
      _data = (json as List)
          .map((item) => ProviderModel.fromJson(item))
          .toList() as T;

    }
    else if ("$T".contains("List<StaticPagesModel>")) {
      _data = (json as List)
          .map((item) => StaticPagesModel.fromJson(item))
          .toList() as T;

    }
    else {
      _data = null;
      return false;
    }

    print(_data);
    return true;
  }

  String? get status => _status;

  String? get msg => _msg;
  int? get code => _activation_code;

  get data => _data;
  set data(value) => _data = value;
}
