import 'package:todo_app/models/todo.dart';
import 'package:todo_app/repositories/todo_repository_http.dart';

/// View Contract to be implemented by views
/// that use a [ToDosPagePreseter]
abstract class ToDosPageViewContract {
  /// Define callback for creating, updating, deleting a [ToDo]
  void onCUDComplete(String response);
  /// Define callback for reading [ToDo]s from the server
  void onReadComplete(Map<String, dynamic> response);
  /// Define callback for returning error messages from the server
  void onError(String error);
}

class ToDosPagePresenter {

  ToDoRepositoryHttp _repository;
  ToDosPageViewContract _view;

  ToDosPagePresenter(this._view) {
    _repository = new ToDoRepositoryHttp();
  }

  create(String text) => _repository.create(text)
    .then(_view.onCUDComplete)
    .catchError(_view.onError);

  read() => _repository.read()
    .then(_view.onReadComplete)
    .catchError(_view.onError);
  
  update(int id) => _repository.update(id)
    .then(_view.onCUDComplete)
    .catchError(_view.onError);

  delete(int id) => _repository.delete(id)
    .then(_view.onCUDComplete)
    .catchError(_view.onError);

}