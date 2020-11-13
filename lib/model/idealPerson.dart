class IdealPerson {
  List<String> genders;
  List<String> orientations;
  String distance;
  int minAge;
  int maxAge;
  List<String> connections;
  List<String> status;
  List<String> bodyTypes;
  int minHeight;
  int maxHeight;
  List<String> ethnicities;
  List<String> religions;
  List<String> signs;
  List<String> politics;
  List<String> employments;
  List<String> educations;
  List<String> langues;
  List<String> alcohol;
  List<String> smoking;
  List<String> marijuana;
  List<String> diets;
  List<String> pets;
  List<String> hasKids;
  List<String> wantKids;

  IdealPerson({
    this.genders,
    this.orientations,
    this.distance,
    this.minAge,
    this.maxAge,
    this.connections,
    this.status,
    this.bodyTypes,
    this.minHeight,
    this.maxHeight,
    this.ethnicities,
    this.religions,
    this.signs,
    this.politics,
    this.employments,
    this.educations,
    this.langues,
    this.alcohol,
    this.smoking,
    this.marijuana,
    this.diets,
    this.pets,
    this.hasKids,
    this.wantKids,
  });

  @override
  String toString() {
    return "Genders : ${genders.join(", ")}\nOrientations : ${orientations.join(", ")}\nDistance : $distance\nMin Age : $minAge\nMax Age : $maxAge\nConnections : ${connections.join(", ")}\nStatus : ${status.join(", ")}\nBody types : ${bodyTypes.join(", ")} \nMin Height : $minHeight, MaxHeight : $maxHeight" +
        "\nEthnicities : ${ethnicities.join(", ")}\nReligions : ${religions.join(", ")}\nSigns : ${signs.join(", ")}\nPolitics : ${politics.join(", ")}\nEmployments : ${employments.join(", ")}\nEducations : ${educations.join(", ")}\nLangues : ${langues.join(", ")}" +
        "\nAlcohol : ${alcohol.join(", ")}\nSmoking : ${smoking.join(", ")}\nMarijuana : ${marijuana.join(", ")}\nDiets : ${diets.join(", ")}" +
        "\nPets : ${pets.join(", ")}\nHas kids : ${hasKids.join(", ")}\nWant Kids : ${wantKids.join(", ")}";
  }

  Map<String, dynamic> toJson() => {
        'genders': this.genders,
        'orientations': this.orientations,
        'distance': this.distance,
        'minAge': this.minAge,
        'maxAge': this.maxAge,
        'connections': this.connections,
        'status': this.status,
        'bodyTypes': this.bodyTypes,
        'minHeight': this.minHeight,
        'maxHeight': this.maxHeight,
        'ethnicities': this.ethnicities,
        'religions': this.religions,
        'signs': this.signs,
        'politics': this.politics,
        'employments': this.employments,
        'educations': this.educations,
        'langues': this.langues,
        'alcohol': this.alcohol,
        'smoking': this.smoking,
        'marijuana': this.marijuana,
        'diets': this.diets,
        'pets': this.pets,
        'hasKids': this.hasKids,
        'wantKids': this.wantKids,
      };
}
