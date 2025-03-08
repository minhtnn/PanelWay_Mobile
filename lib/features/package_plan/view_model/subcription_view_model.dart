import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/exceptions/api_exception.dart';
import 'package:panelway_mobile/data/models/subscription.dart';
import 'package:panelway_mobile/data/repositories/subcriptionRepository.dart';

class SubcriptionViewModel extends ChangeNotifier {
  final Subcriptionrepository _subcriptionrepository;

  SubcriptionViewModel({required Subcriptionrepository subcriptionrepository})
      : _subcriptionrepository = subcriptionrepository;

  bool _isLoading = false;
  String? _error;
  List<Subscription>? _subcriptions;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Subscription>? get subcriptions => _subcriptions;

  Future<List<Subscription>?> getSubcriptions() async {
    if (_isLoading) return _subcriptions;
    _isLoading = true;
    notifyListeners();
    _error = null;
    try {
      var subcriptionList =
          await _subcriptionrepository.getSubcriptions();
        _subcriptions = subcriptionList;
      _isLoading = false;
      notifyListeners();
      return null;
    } on ApiException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _error = 'Unexpected error occurred: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }
}
