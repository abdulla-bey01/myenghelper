import 'package:flutter/foundation.dart';
import 'package:my_eng_helper/data/notes-db-helper.dart';
import 'package:my_eng_helper/models/used-word.dart';

class NotesProvider with ChangeNotifier {
  List<UsedWord> _notes = [];
  List<UsedWord> _showingNotes;
  List<UsedWord> get notes => _showingNotes == null ? _notes : _showingNotes;

  InitStatus _initStatus = InitStatus.Default;
  InitStatus get initStatus => _initStatus;
  void _updateInitStatus(InitStatus state, {bool notify = false}) {
    _initStatus = state;
    if (notify) notifyListeners();
  }

  bool _inited = false;
  void init({bool force = false}) async {
    if (_inited && !force) return;
    try {
      _updateInitStatus(InitStatus.Waiting);
      NotesDbHelper().getNotes()
        ..then(
          (value) {
            _notes = value;
            _inited = true;
            _updateInitStatus(InitStatus.Succes, notify: true);
            //notifyListeners();
          },
        );
    } catch (e) {}
  }

  void add(UsedWord model) {
    _notes.add(model);
    _showingNotes = _notes;
    notifyListeners();
  }

  void remove(UsedWord model) {
    _notes.remove(_notes.firstWhere((element) => element.id == model.id));
    _showingNotes = _notes;
    notifyListeners();
  }

  void search({String tip}) {
    try {
      final _tempNotes = _notes
          .where((element) =>
              element.word.toLowerCase().contains(tip.toLowerCase()) ||
              element.translation.toLowerCase().contains(tip.toLowerCase()) ||
              element.synonims.toLowerCase().contains(tip.toLowerCase()) ||
              element.sentenceItisUsedIn
                  .toLowerCase()
                  .contains(tip.toLowerCase()))
          .toList();
      if (_tempNotes.length > 0) {}
      _showingNotes = _tempNotes;
    } catch (error) {
      debugPrint('error on search note');
    } finally {
      notifyListeners();
    }
  }
}

enum InitStatus { Default, Waiting, Succes, Unsucces }
