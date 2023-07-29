class RandomUserData {
  Info? info;
  List<Results>? results;

  RandomUserData(
    this.info,
    this.results,
  );

  RandomUserData.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
}

class Results {
  String? gender;
  Name? name;
  Location? location;
  String? email;
  String? phone;
  Picture? picture;

  Results(
    this.gender,
    this.name,
    this.location,
    this.email,
    this.phone,
    this.picture,
  );

  Results.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    email = json['email'];
    phone = json['phone'];
    picture =
        json['picture'] != null ? Picture.fromJson(json['picture']) : null;
  }
}

class Name {
  String? title;
  String? first;
  String? last;

  Name(
    this.title,
    this.first,
    this.last,
  );

  Name.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    first = json['first'];
    last = json['last'];
  }
}

class Location {
  String? country;

  Location(
    this.country,
  );

  Location.fromJson(Map<String, dynamic> json) {
    country = json['country'];
  }
}

class Picture {
  String? large;
  String? medium;
  String? thumbnail;

  Picture(
    this.large,
    this.medium,
    this.thumbnail,
  );

  Picture.fromJson(Map<String, dynamic> json) {
    large = json['large'];
    medium = json['medium'];
    thumbnail = json['thumbnail'];
  }
}

class Info {
  String? seed;
  int? results;
  int? page;

  Info(
    this.seed,
    this.results,
    this.page,
  );

  Info.fromJson(Map<String, dynamic> json) {
    seed = json['seed'];
    results = json['results'];
    page = json['page'];
  }
}
