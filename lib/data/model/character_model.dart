
class CharactersModel {
  List<Results>? results;


  CharactersModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }


}


class Results {
  int? id;
  String? name;
  String? status;
  String? species;
  String? gender;
  String? image;
  String? created;


  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    gender = json['gender'];
    image = json['image'];
    created = json['created'];
  }

}

