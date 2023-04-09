class CategoryItem {
  String? sId;
  String? nameCategory;

  CategoryItem({this.sId, this.nameCategory});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nameCategory = json['name_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name_category'] = this.nameCategory;

    return data;
  }
}
