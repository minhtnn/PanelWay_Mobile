import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:panelway_mobile/data/models/account.dart';

class StorageService {
  final _storage = const FlutterSecureStorage();
  static const _accountKey = 'account_data';

  Future<void> saveAccount(Account account) async {
    try {
      final accountJson = json.encode(account.toJson());
      // print("Saving account in save account method: ${accountJson}");

      await _storage.write(key: _accountKey, value: accountJson);
      // print("Account saved successfully");
    } catch (e) {
      print("Error saving account: $e");
    }
  }

  Future<Account?> getAccount() async {
    final accountJson = await _storage.read(key: _accountKey);
    if (accountJson != null) {
      // var account = Account.fromJson2(json.decode(accountJson));
      return Account.fromJson2(json.decode(accountJson));
    }
    return null;
  }

  Future<void> clearAccount() async {
    await _storage.delete(key: _accountKey);
  }
}
