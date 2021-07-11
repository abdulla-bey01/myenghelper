import 'package:flutter/material.dart';
import 'package:my_eng_helper/screens/new-word-screen.dart';
import 'package:my_eng_helper/widgets/words-widget.dart';
import 'package:page_transition/page_transition.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);
  static const route = '/main-screen';

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
          'SavEng',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 22.0,
          ),
        ),
      ),
      body: ImportantNotesWidget(
        parentSize: Size(
          _size.width,
          _size.height - MediaQuery.of(context).viewInsets.top,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              ctx: context,
              child: NewNoteScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
