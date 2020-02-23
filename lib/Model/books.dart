class Books {
  String uploadDate;
  String name;
  String author;
  bool isAvailable;

  Books({this.uploadDate, this.name, this.author, this.isAvailable});

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
        uploadDate: json['book']['uploadDate'],
        name: json['book']['bookName'],
        author: json['book']['author'],
        isAvailable: json['book']['isAvailable']);
  }
}
