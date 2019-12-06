class JobModel {
  String id;
  DateTime createdAt;
  String snippet;
  String url;
  String title;
  String shareLink;

  JobModel({
    this.id,
    this.createdAt,
    this.snippet,
    this.url,
    this.title,
    this.shareLink,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
    id: json["id"] == null ? null : json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]).subtract(Duration(hours: 3)),
    snippet: json["snippet"] == null ? null : json["snippet"],
    url: json["url"] == null ? null : json["url"],
    title: json["title"] == null ? null : json["title"],
    shareLink: json["shareLink"] == null ? null : json["shareLink"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "snippet": snippet == null ? null : snippet,
    "url": url == null ? null : url,
    "title": title == null ? null : title,
    "shareLink": shareLink == null ? null : shareLink,
  };
}