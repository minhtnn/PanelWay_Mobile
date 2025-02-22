enum SpaceStatusConstrant { available, draft, unavailable }
enum RentalTimeUnit{month, year}

extension SpaceStatusExtension on SpaceStatusConstrant {
  String get lable {
    switch (this) {
      case SpaceStatusConstrant.available:
        return "Available";
      case SpaceStatusConstrant.draft:
        return "Draft";
      case SpaceStatusConstrant.unavailable:
        return "Unavailable";
    }
  }
}
List<Map<String, String>> getSpaceStatusAsMap() {
  return SpaceStatusConstrant.values.map((e) => {"label": e.lable, "value": e.name}).toList();
}

extension RentalTimeUnitExtension on RentalTimeUnit {
  String get lable {
    switch (this) {
      case RentalTimeUnit.month:
        return "month";
      case RentalTimeUnit.year:
        return "year";
    }
  }
}
List<Map<String, String>> getRentalTimeUnitAsMap() {
  return RentalTimeUnit.values.map((e) => {"label": e.lable, "value": e.name}).toList();
}