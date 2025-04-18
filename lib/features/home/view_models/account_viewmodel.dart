import 'package:flutter/material.dart';
import 'package:panelway_mobile/data/models/account.dart';
import 'package:panelway_mobile/data/payloads/responses/accountResponse.dart';
import 'package:panelway_mobile/data/repositories/accountRepository.dart';

class AccountViewmodel extends ChangeNotifier{
  final AccountRepository _accountRepository;
  AccountViewmodel({required AccountRepository accountRepository}): _accountRepository = accountRepository;

  Future<AccountResponse?> getAccountById(String id) async {
    try {
      var account = await _accountRepository.getAccountById(id);
      return account;
    } catch (e) {
      debugPrint("Error in account viewmodel: " + e.toString());
      return null;
    }
  }
}