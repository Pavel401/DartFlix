class User {
  final String moviename;
  final String url;
  final String id;

  User(this.moviename, this.url, this.id);

  //constructor that convert json to object instance
  User.fromJson(Map<String, dynamic> json)
      : moviename = json['moviename'],
        url = json['url'],
        id = json['id'];

  //a method that convert object to json
  Map<String, dynamic> toJson() =>
      {'moviename': moviename, 'url': url, 'phone': id};
}
