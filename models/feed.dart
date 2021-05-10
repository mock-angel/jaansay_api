class Feed {
  Feed({
    this.feedId,
    this.feedTitle,
    this.feedDescription,
    this.likes,
    this.userId,
    this.docId,
    this.updatedAt,
    this.officialsName,
    this.photo,
    this.typeName,
    this.isLiked,
    this.media,
  });

  String feedId;
  String feedTitle;
  String feedDescription;
  int likes;
  int userId;
  int docId;
  DateTime updatedAt;
  String officialsName;
  String photo;
  String typeName;
  int isLiked;
  List media;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        feedId: json["feed_id"],
        feedTitle: json["feed_title"],
        feedDescription: json["feed_description"],
        likes: json["likes"],
        userId: json["user_id"],
        docId: json["doc_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        officialsName: json["officials_name"],
        photo: json["photo"] == null ? 'no photo' : json["photo"],
        typeName: json["type_name"],
        isLiked: json["is_liked"],
        media: json["media"] == null ? [] : json["media"].toString().split(","),
      );
}

class FeedFilter {
  FeedFilter({
    this.filterId,
    this.filterName,
    this.filterType,
  });

  int filterId;
  String filterName;
  String filterType;

  factory FeedFilter.fromJson(Map<String, dynamic> json) => FeedFilter(
        filterId: json["filter_id"],
        filterName: json["filter_name"],
        filterType: json["filter_type"],
      );
}
