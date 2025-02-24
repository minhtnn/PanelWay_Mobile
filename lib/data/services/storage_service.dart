import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:panelway_mobile/data/models/account.dart';

class StorageService {
  final _storage = const FlutterSecureStorage();
  static const _accountKey = 'account_data';

  Future<void> saveAccount(Account account) async {
    final accountJson = json.encode(account.toJson());
    await _storage.write(key: _accountKey, value: accountJson);
  }

  Future<Account?> getAccount() async {
    final accountJson = await _storage.read(key: _accountKey);
    if (accountJson != null) {
      return Account.fromJson(json.decode(accountJson));
    }
    return null;
  }

  Future<void> clearAccount() async {
    await _storage.delete(key: _accountKey);
  }
}