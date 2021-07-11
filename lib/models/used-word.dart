import 'package:hive/hive.dart';
part 'used-word.g.dart';

@HiveType(typeId: 0)
class UsedWord extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String word;
  @HiveField(2)
  String translation;
  @HiveField(3)
  String sentenceItisUsedIn;
  @HiveField(4)
  String synonims;
  @HiveField(5)
  DateTime dateTime;
  UsedWord.createLocal(
      {this.id,
      this.sentenceItisUsedIn,
      this.synonims,
      this.translation,
      this.word}) {
    this.dateTime = DateTime.now();
  }
  UsedWord(this.dateTime, this.id, this.sentenceItisUsedIn, this.synonims,
      this.translation, this.word);
  // NoteModel.createLocal({this.id, this.content, this.title}) {
  //   this.dateTime = DateTime.now();
  // }
  // NoteModel(this.content, this.dateTime, this.id, this.title);
}
