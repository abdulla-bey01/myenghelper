import 'package:flutter/material.dart';
import 'package:my_eng_helper/data/notes-db-helper.dart';
import 'package:my_eng_helper/models/used-word.dart';
import 'package:my_eng_helper/providers/notes-provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class NoteDetailsScreen extends StatefulWidget {
  NoteDetailsScreen({Key key, this.note, this.index}) : super(key: key);
  static const route = '/note-detail-screen';
  final UsedWord note;
  final int index;

  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();
  TextEditingController _sentenceController = new TextEditingController();
  TextEditingController _synonymController = new TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.note.word;
    _contentController.text = widget.note.translation;
    _sentenceController.text = widget.note.sentenceItisUsedIn;
    _synonymController.text = widget.note.synonims;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _ctxTheme = Theme.of(context);
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _ctxTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: _ctxTheme.accentColor,
        centerTitle: true,
        title: Text(
          'Definiton',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 22.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              NotesDbHelper().remove(index: widget.index).then((value) {
                Provider.of<NotesProvider>(context, listen: false)
                    .remove(widget.note);
                final _note = UsedWord.createLocal(
                  id: Uuid().v1(),
                  word: _titleController.text,
                  translation: _contentController.text,
                  sentenceItisUsedIn: _sentenceController.text,
                  synonims: _synonymController.text,
                );
                NotesDbHelper().addNote(_note);
                Provider.of<NotesProvider>(context, listen: false).add(_note);
                Navigator.of(context).pop();
                // Provider.of<NotesProvider>(context, listen: false)
                //     .init(force: true);
              });
              //Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        width: _size.width,
        height: _size.height - MediaQuery.of(context).viewInsets.top,
        child: ListView(
          children: [
            Container(
              height: 50,
              width: _size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  controller: _titleController,
                  autofocus: false,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Word',
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 25.0,
                      letterSpacing: 0,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 3,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 3,
                      ),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 3,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 25.0,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: _contentController,
                minLines: 1,
                maxLines: 20,
                autofocus: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Tranlation',
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 22.0,
                    letterSpacing: 0,
                  ),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 3,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 3,
                    ),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 3,
                    ),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 22.0,
                  letterSpacing: 0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: _sentenceController,
                minLines: 1,
                maxLines: 20,
                autofocus: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Sentence the word is used id',
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 22.0,
                    letterSpacing: 0,
                  ),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 3,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 3,
                    ),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 3,
                    ),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 22.0,
                  letterSpacing: 0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: _synonymController,
                minLines: 1,
                maxLines: 20,
                autofocus: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Synonyms',
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 22.0,
                    letterSpacing: 0,
                  ),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 3,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 3,
                    ),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 3,
                    ),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 22.0,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
