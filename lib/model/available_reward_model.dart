class AvailableRewardModel {
  final String storeName;
  final String title;
  final String id;
  final String storeId;
  final String expiry;
  final String storeLogoUrl;
  final String storeCoverUrl;
  final String points;
  final bool isLocked;

  AvailableRewardModel(
      {this.storeName,
        this.storeLogoUrl,
        this.storeCoverUrl,
        this.id,
        this.isLocked,
        this.storeId,
        this.expiry,
        this.points,
        this.title});

  AvailableRewardModel.fromJson(Map<String, dynamic> json)
      : title = json['title'].toString(),
        isLocked = json['is_lock'].toString() != '1',
        id = json['rewards_id'].toString(),
        storeId = json['stores_id'].toString(),
        expiry = json['expiry'].toString(),
        storeName = json['store_name'].toString(),
        storeLogoUrl = json['store_logo'].toString(),
        storeCoverUrl = json['image'].toString(),
        points = json['required_load_point'].toString();
}
