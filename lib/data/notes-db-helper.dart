import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:my_eng_helper/models/used-word.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class NotesDbHelper {
  Future<void> addNote(UsedWord note) async {
    try {
      try {
        await _init();
      } catch (e) {}
      var _box = await Hive.openBox('notes');
      await _box.add(note);
      _box.close();
    } catch (error) {
      debugPrint(error);
    }
  }

  Future<List<UsedWord>> getNotes() async {
    try {
      try {
        await _init();
      } catch (e) {}
      var _box = await Hive.openBox('notes');
      final _res = _box.toMap();
      List<UsedWord> _notes = [];
      _res.forEach((key, value) {
        _notes.add(value as UsedWord);
      });
      _box.close();
      return _notes;
    } catch (error) {
      return [];
    }
  }

  Future<void> remove({int index}) async {
    try {
      try {
        await _init();
      } catch (e) {}
      var _box = await Hive.openBox('notes');
      await _box.deleteAt(index);
      _box.close();
      debugPrint('note removed');
    } catch (error) {
      debugPrint(error);
    }
  }

  Future<void> _init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path + '/appdb.hive';
    Hive..init(path);
    Hive..registerAdapter(UsedWordAdapter());
  }
}
