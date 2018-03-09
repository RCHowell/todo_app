/// Model to interact with TODOs
/// 
/// Defaults to create a blank [TODO],
/// but has a named constructor for creating from JSON
class ToDo {
  /// Id is the time created in miliseconds
  final int id;
  /// Is the [TODO] done or not?
  final bool done;
  /// What is there to do?
  final String text;

  /// Default constructor for a [TODO]
  ToDo({
    id,
    this.done = false,
    this.text = 'New Todo'
  }) : this.id = (id == null) ? new DateTime.now().millisecond : id;

  /// Create a new [TODO] assuming we have the same formatted
  /// JS Object as our API backend returns
  ToDo.fromJSON(Map<String, dynamic> json) :
    this.id = json['id'],
    this.done = json['done'],
    this.text = json['text'];
}
