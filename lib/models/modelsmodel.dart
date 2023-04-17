class ModelsModel {
  final String id;
  final int created;
  final String root;

  ModelsModel({
    required this.id,
    required this.root,
    required this.created,
  });

  factory ModelsModel.fromJson(Map<String, dynamic> json) {
    return ModelsModel(
      id: json["id"],
      root: json["root"],
      created: json["created"],
    );
  }
  static List<ModelsModel> modelsFromSnapshot(List modelSnapshot){
    return modelSnapshot.map((data) => ModelsModel.fromJson(data) ).toList();
  }

  static List<String> getmodels(List modelSnapshot){
    return modelSnapshot.map((data) => ModelsModel.fromJson(data).id ).toList();
  }
}