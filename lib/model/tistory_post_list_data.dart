class TistoryPostListData {
  Tistory? tistory;

  TistoryPostListData({this.tistory});

  TistoryPostListData.fromJson(Map<String, dynamic> json) {
    tistory =
        json['tistory'] != null ? Tistory.fromJson(json['tistory']) : null;
  }
}

class Tistory {
  String? status;
  Item? item;

  Tistory(
    this.status,
    this.item,
  );

  Tistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
  }
}

class Item {
  String? url;
  String? secondaryUrl;
  String? page;
  String? count;
  String? totalCount;
  List<Posts>? posts;

  Item(
    this.url,
    this.secondaryUrl,
    this.page,
    this.count,
    this.totalCount,
    this.posts,
  );

  Item.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    secondaryUrl = json['secondaryUrl'];
    page = json['page'];
    count = json['count'];
    totalCount = json['totalCount'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
  }
}

class Posts {
  String? id;
  String? title;
  String? postUrl;
  String? visibility;
  String? categoryId;
  String? comments;
  String? trackbacks;
  String? date;

  Posts(
    this.id,
    this.title,
    this.postUrl,
    this.visibility,
    this.categoryId,
    this.comments,
    this.trackbacks,
    this.date,
  );

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    postUrl = json['postUrl'];
    visibility = json['visibility'];
    categoryId = json['categoryId'];
    comments = json['comments'];
    trackbacks = json['trackbacks'];
    date = json['date'];
  }
}
