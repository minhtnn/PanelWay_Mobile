enum SpaceStatusEnum { available, draft, unavailable }
enum RentalTimeUnit{month, year}

extension SpaceStatusExtension on SpaceStatusEnum {
  String get lable {
    switch (this) {
      case SpaceStatusEnum.available:
        return "Available";
      case SpaceStatusEnum.draft:
        return "Draft";
      case SpaceStatusEnum.unavailable:
        return "Unavailable";
    }
  }
}
List<Map<String, String>> getSpaceStatusAsMap() {
  return SpaceStatusEnum.values.map((e) => {"label": e.lable, "value": e.name}).toList();
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