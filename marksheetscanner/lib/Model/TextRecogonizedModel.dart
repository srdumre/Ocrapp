class CSVFileModel {
  final int id;
  final String filePath;
  final DateTime createdAt;

  CSVFileModel(
      {required this.id, required this.filePath, required this.createdAt});

  factory CSVFileModel.fromJson(Map<String, dynamic> json) {
    return CSVFileModel(
      id: json['id'],
      filePath: json['file'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
