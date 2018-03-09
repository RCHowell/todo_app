import 'dart:async';

/// Defines an interface for a [ToDo] repository
abstract class ToDoRepository {
  /// Create a new [ToDo] and
  /// throws error string
  Future<String> create(String text);
  /// Return a map with list of every [ToDo]
  /// and an error object
  /// 
  /// Returns {
  ///   error: ...,
  ///   todos: ...,
  /// }
  Future<Map<String, dynamic>> read();
  /// Update the status of one [ToDo]
  Future<String> update(int id);
  /// Delete the specified [ToDo]
  Future<String> delete(int id);
}
