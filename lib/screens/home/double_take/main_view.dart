import '../../../widgets/CircularProgressWidget.dart';
import '../../../widgets/provider_widget.dart';
import '../../../model/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'best_match_qst/answer_questions_view.dart';
import 'package:flutter/material.dart';
import 'users_card.dart';

class DoubleTakeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DoubleTakeStateView();
  }
}

class _DoubleTakeStateView extends State<DoubleTakeView> {
  Profile profile = new Profile();
  Stream<QuerySnapshot> getUserProfileStreamSnapchots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    profile.uid = uid;
    yield* Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('profile')
        .snapshots();
  }

  Stream<QuerySnapshot> getUserBestMatchQuestionsStreamSnapchots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    profile.uid = uid;
    yield* Firestore.instance
        .collection("userData")
        .document(uid)
        .collection('bestMatch')
        .snapshots();
  }

  StreamBuilder getBestMatchQuestions(BuildContext context) {
    return StreamBuilder(
      stream: getUserBestMatchQuestionsStreamSnapchots(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.documents.length > 0) return UserCardView();
          return AnswerQuestionsView(
            profile: profile,
          );
        }
        return CircularProgressWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getUserProfileStreamSnapchots(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            profile.profileImageUrl =
                snapshot.data.documents[0]['profileImageUrl'];
            return getBestMatchQuestions(context);
          }
          return CircularProgressWidget();
        },
      ),
    );
  }
}
