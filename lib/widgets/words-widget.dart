import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_eng_helper/providers/notes-provider.dart';
import 'package:my_eng_helper/screens/word-details-screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../helpers/date-time-extensions.dart';

class ImportantNotesWidget extends StatelessWidget {
  const ImportantNotesWidget({Key key, this.parentSize}) : super(key: key);
  final Size parentSize;

  @override
  Widget build(BuildContext context) {
    final _ctxTheme = Theme.of(context);
    final _notesProvider = Provider.of<NotesProvider>(context);
    _notesProvider.init();
    final _notes = _notesProvider.notes;
    final _initState = _notesProvider.initStatus;

    return Container(
      height: parentSize.height,
      width: parentSize.width,
      child: _initState == InitStatus.Waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Container(
                  height: 80,
                  width: parentSize.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: null,
                      autofocus: false,
                      onChanged: (value) {
                        _notesProvider.search(tip: value);
                      },
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: 'Search something',
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
                        suffixIcon: Container(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.5),
                            size: 30,
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
                Container(
                  height: parentSize.height - 156,
                  width: parentSize.width,
                  child: _notes.length <= 0
                      ? Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'ummm, sorry, we could find nothing',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                      : StaggeredGridView.countBuilder(
                          crossAxisCount: 4,
                          itemCount: _notes.length,
                          itemBuilder: (BuildContext context, int index) {
                            final _note = _notes[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      ctx: context,
                                      child: NoteDetailsScreen(
                                        note: _note,
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      16.0,
                                    ),
                                    color: Colors.white.withOpacity(0.05),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        constraints:
                                            BoxConstraints(maxHeight: 50),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0,
                                                left: 12.0,
                                                right: 12.0),
                                            child: SingleChildScrollView(
                                              child: Text(
                                                _note.word,
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 27.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Divider(
                                          color: _ctxTheme.accentColor,
                                          thickness: 3,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16.0,
                                              left: 12.0,
                                              right: 12.0,
                                              bottom: 8.0),
                                          child: Text(
                                            _note.translation,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Divider(
                                          color: Colors.white.withOpacity(0.1),
                                          thickness: 3,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0,
                                              left: 12.0,
                                              right: 12.0,
                                              bottom: 8.0),
                                          child: Text(
                                            _note.dateTime.getDate(),
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.fit(2),
                        ),
                ),
              ],
            ),
    );
  }
}
