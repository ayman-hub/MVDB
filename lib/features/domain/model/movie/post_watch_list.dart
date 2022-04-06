class PostWatchListModel {
  String? mediaType;
  String? mediaId;
  bool? watchlist;
  String? accountID;

  String? sessionID;

  PostWatchListModel(
      {this.mediaType,
      this.mediaId,
      this.watchlist,
      this.accountID,
      this.sessionID});

  PostWatchListModel.fromJson(Map<String, dynamic> json) {
    mediaType = json['media_type'];
    mediaId = json['media_id'].toString();
    watchlist = json['watchlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media_type'] = mediaType;
    data['media_id'] = mediaId;
    data['watchlist'] = watchlist;
    return data;
  }
}
