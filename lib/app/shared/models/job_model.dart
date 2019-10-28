class JobModel {
  DateTime createdAt;
  String snippet;
  String url;
  String title;

  JobModel({
    this.createdAt,
    this.snippet,
    this.url,
    this.title,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]).subtract(Duration(hours: 3)),
    snippet: json["snippet"] == null ? null : json["snippet"],
    url: json["url"] == null ? null : json["url"],
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "snippet": snippet == null ? null : snippet,
    "url": url == null ? null : url,
    "title": title == null ? null : title,
  };
}