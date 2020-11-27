class OfferModel {
  final String title;
  final String storeImage;
  final bool isLocked;
  final String storeOwner;
  final String storeId;
  final String requiredLoadPoints;
  final String date;
  final String expiry;
  final String id;


  OfferModel( {this.title, this.storeImage, this.storeOwner,this.expiry, this.requiredLoadPoints, this.date,
       this.storeId, this.id, this.isLocked});

  OfferModel.fromJson(Map<String, dynamic> json)
      : storeId = json['stores_id'].toString(),
        storeOwner= json['store_owner'].toString(),
        isLocked = json['is_lock'].toString() != '1',
        storeImage = json['image'].toString(),
        requiredLoadPoints= json['required_load_point'].toString(),
        title = json['title'].toString(),
        expiry = json['expiry'].toString(),
        date  = json['created_at'].toString(),
        id = json['offer_id'].toString();

}

