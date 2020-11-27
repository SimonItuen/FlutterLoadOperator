import 'offer_model.dart';

class StoreModel {
  final String name;
  final String logoUrl;
  final String id;
  final String coverImageUrl;
  final String joinedOn;
  final String myPoints;
  final String totalOrders;
  final String categoryName;
  final List<OfferModel> list;

  StoreModel({
    this.name,
    this.logoUrl,
    this.id,
    this.coverImageUrl,
    this.joinedOn,
    this.myPoints,
    this.totalOrders,
    this.categoryName,
    this.list,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    List<OfferModel> list = new List<OfferModel>();
    for (Map i in json['my_offers']) {
       list.add(OfferModel.fromJson(i));
    }
    return StoreModel(
        name: json['store_details']['store_name'].toString(),
        logoUrl: json['store_details']['store_logo'].toString(),
        coverImageUrl: json['store_details']['store_cover_image'].toString(),
        joinedOn: json['store_details']['joined_on'].toString(),
        myPoints: json['store_details']['my_points'].toString(),
        categoryName: json['store_details']['category_name'].toString(),
        totalOrders: json['store_details']['total_orders'].toString(),
        list: list);
  }
}
