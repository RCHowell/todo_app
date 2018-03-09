import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/presenters/todos_page_presenter.dart';

class ToDosPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ToDosPageState();

}

class _ToDosPageState extends State<ToDosPage> implements ToDosPageViewContract {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _textController = new TextEditingController();
  ToDosPagePresenter _presenter;
  List<ToDo> _todos;

  @override
  void initState() {
    super.initState();
    _presenter = new ToDosPagePresenter(this);
    _todos = new List();
    _presenter.read();
  }

  @override
  void onCUDComplete(String response) {
    _presenter.read();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(response.replaceAll('"', '')),
    ));
  }

  @override
  void onError(String error) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(error),
      backgroundColor: Colors.red,
    ));
  }

  @override
  void onReadComplete(Map<String, dynamic> response) {
    if (response['error'] == null) {
      setState(() {
        _todos = response['todos'];
        _todos.sort((a, b) => a.id.compareTo(b.id));
      });
    } else {
      onError(response['error']);
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget empty = new Center(
      child: new Text('Nothing To Do'),
    );

    Widget dialog = new AlertDialog(
      title: const Text('Create a ToDo'),
      content: new TextField(
        controller: _textController,
        decoration: new InputDecoration(
          hintText: 'What\'s there to do?',
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: const Text('CLOSE'),
          onPressed: () { Navigator.pop(context); }
        ),
        new FlatButton(
          child: const Text('SAVE'),
          onPressed: () {
            _presenter.create(_textController.text);
            _textController.clear();
            Navigator.pop(context);
          }
        )
      ]
    );

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('TODOs'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.refresh),
            onPressed: () {
              _presenter.read();
            },
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        backgroundColor: Colors.orange,
        onPressed: () {
          showDialog(
            context: context,
            child: dialog
          );
        },
      ),
      body: (_todos?.length > 0) ? new ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: _todos.map((t) => new ListTile(
            leading: new Checkbox(
              value: t.done,
              onChanged: (bool val) {
                _presenter.update(t.id);
              },
            ),
            title: new Text(t.text),
            // subtitle: new Text(t.id.toString()),
            trailing: new IconButton(
              icon: new Icon(Icons.delete_outline),
              onPressed: () {
                _presenter.delete(t.id);
              },
            )
          )).toList()
        ).toList(),
      ) : empty,
    );
  }
  
}
