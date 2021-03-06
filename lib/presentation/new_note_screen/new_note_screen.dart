import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/entities/note_model.dart';
import 'package:notes_app/presentation/home_screen/home_screen.dart';
import 'package:notes_app/services/database.dart';
import 'package:notes_app/utils/utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../components/components.dart';

final noteTitleProvider = StateProvider<String?>((ref) => null);

final noteContentProvider = StateProvider<String?>((ref) => null);

class NewNoteScreen extends ConsumerStatefulWidget {
  const NewNoteScreen({Key? key}) : super(key: key);

  static const route = 'newNoteRoute';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends ConsumerState<NewNoteScreen> {
  Box<NoteModel>? storeData;

  bool? _isNotEmpty;

  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    storeData = Hive.box<NoteModel>(Strings.noteBox);
  }

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  Future<bool> checkIfNoteIsNotEmpty() async {
    /// Check if there is either content or title
    if (_noteContentController.text.isNotEmpty ||
        _noteTitleController.text.isNotEmpty) {
      final String noteTitle = _noteTitleController.text;
      final String noteContent = _noteContentController.text;
      await HiveDatabaseService().createNewNote(
        noteTitle: noteTitle,
        noteContent: noteContent,
      );
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note Saved'),
      ),  
      );
      Navigator.of(context).pop();
      await Navigator.of(context).pushNamed(HomeScreen.route);
      _isNotEmpty = true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Empty Note Discarded'),
        ),
      );
      Navigator.of(context).pop();
      await Navigator.of(context).pushNamed(HomeScreen.route);
      _isNotEmpty = false;
    }
    return _isNotEmpty!;
  }

  @override
  Widget build(BuildContext context) {
    // final newNote = ref.watch(noteContentProvider);
    return WillPopScope(
      onWillPop: checkIfNoteIsNotEmpty,
      child: Scaffold(
        backgroundColor: AppColors.utilityColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.utilityColor,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: AppColors.fabBgColor,
          ),
          leading: Platform.isIOS
              ? CustomIconButton(
                  icon: const Icon(CupertinoIcons.back),
                  onPressed: checkIfNoteIsNotEmpty,
                )
              : null,
          actions: [
            CustomIconButton(
              icon: const Icon(PhosphorIcons.pushPinSimpleBold),
              onPressed: () {},
            ),
            CustomIconButton(
              icon: const Icon(PhosphorIcons.bookmarkSimpleBold),
              onPressed: () {},
            ),
            CustomIconButton(
              icon: const Icon(PhosphorIcons.archiveBoxBold),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          primary: true,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 3,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                TextField(
                  controller: _noteTitleController,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.left,
                  textInputAction: TextInputAction.next,
                  style: Theme.of(context).textTheme.headline2,
                  cursorHeight: 30,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                    hintText: Strings.titleHintText,
                    hintStyle: Theme.of(context).textTheme.headline2,
                  ),
                ),
                TextField(
                  controller: _noteContentController,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.left,
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context).textTheme.bodyText1,
                  cursorHeight: 25,
                  cursorWidth: 1,
                  maxLines: null,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: Strings.noteHintText,
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
