
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/account.dart';
import '../../model/comment.dart';
import '../../utils/firestore/rooms.dart';
import '../../utils/firestore/users.dart';
import 'my_comment_widget.dart';
import 'someone_comment_widget.dart';

class CommentWidget extends StatelessWidget {
  final String roomId;
  final String checkListId;
  final String itemId;
  final Account myAccount;

  const CommentWidget({
    Key? key,
    required this.roomId,
    required this.checkListId,
    required this.itemId,
    required this.myAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: RoomFirestore.rooms.doc(roomId)
              .collection('check_lists').doc(checkListId)
              .collection('comments').orderBy('created_time', descending: false).where('item_id', isEqualTo: itemId)
              .snapshots(),
          builder: (context, commentSnapshot) {
            if(commentSnapshot.hasData) {
              List<String> postAccountIds = [];
              for (var doc in commentSnapshot.data!.docs) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                if (!postAccountIds.contains(data['post_account_id'])) {
                  postAccountIds.add(data['post_account_id']);
                }
              }
              return FutureBuilder<Map<String, Account>?>(
                  future: UserFirestore.getPostUserMap(postAccountIds),
                  builder: (context, userSnapshot) {
                    if(userSnapshot.hasData && userSnapshot.connectionState == ConnectionState.done) {
                      if (commentSnapshot.data!.docs.isEmpty) return Container(padding: const EdgeInsets.symmetric(vertical: 20.0), child: const Text('コメントはまだありません'));
                      return ListView.builder(
                          itemCount: commentSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data = commentSnapshot.data!.docs[index].data() as Map<String, dynamic>;
                            Comment comment = Comment(
                                text: data['text'],
                                itemId: data['item_id'],
                                postAccountId: data['post_account_id'],
                                createdTime: data['created_time']
                            );
                            Account postAccount = userSnapshot.data![comment.postAccountId]!;
                            if (comment.postAccountId == myAccount.id) {
                              return MyCommentWidget(comment: comment, postAccount: postAccount);
                            } else {
                              return SomeOneCommentWidget(comment: comment, postAccount: postAccount);
                            }
                          });
                    } else {
                      return Container();
                    }
                  }
              );
            } else {
              return Container();
            }
          }
      ),
    );
  }
}