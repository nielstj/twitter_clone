import 'package:flutter/material.dart';
import 'package:feeds_repository/feeds_repository.dart';

typedef OnSaveCallback = Function(String message);

class AddEditPage extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Feed? feed;

  AddEditPage(
      {Key? key, required this.onSave, required this.isEditing, this.feed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _message;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Feed' : 'Add Feed',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.feed?.message : '',
                autofocus: !isEditing,
                maxLines: 10,
                maxLength: 280,
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: "What's up Doc?",
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter some text';
                  }
                },
                onSaved: (value) => _message = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isEditing ? 'Save changes' : 'Add Feed',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          final currentState = _formKey.currentState;
          if (currentState != null && currentState.validate()) {
            currentState.save();
            final task = _message;
            if (task != null) widget.onSave(task);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
