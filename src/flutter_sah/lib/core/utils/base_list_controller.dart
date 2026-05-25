import 'package:flutter/foundation.dart';
import 'result.dart';

enum ListStatus { loading, loaded, error }

abstract class BaseListController<T> extends ChangeNotifier {
  ListStatus _status = ListStatus.loading;
  List<T> _items = [];
  String? _error;

  ListStatus get status => _status;
  List<T> get items => _items;
  String? get error => _error;

  bool get isLoading => _status == ListStatus.loading;
  bool get hasError => _status == ListStatus.error;

  Future<Result<List<T>>> fetchItems();

  Future<void> load() async {
    _status = ListStatus.loading;
    _error = null;
    notifyListeners();

    final result = await fetchItems();
    result.fold(
      onSuccess: (list) {
        _items = list;
        _status = ListStatus.loaded;
      },
      onFailure: (msg) {
        _error = msg;
        _status = ListStatus.error;
      },
    );

    notifyListeners();
  }
}
