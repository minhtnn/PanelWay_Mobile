enum UserRoleEnum { AdvertisingClient, SpaceProvider}
extension UserRoleExtension on UserRoleEnum {
  String get lable {
    switch (this) {
      case UserRoleEnum.AdvertisingClient:
        return "AdvertisingClient";
      case UserRoleEnum.SpaceProvider:
        return "SpaceProvider";
    }
  }
}

List<Map<String, String>> getUserRoleAsMap() {
  return UserRoleEnum.values.map((e) => {"label": e.lable, "value": e.name}).toList();
}