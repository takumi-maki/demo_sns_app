import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_sns_app/model/comment.dart';
import 'package:demo_sns_app/utils/authentication.dart';
import 'package:demo_sns_app/utils/firestore/comments.dart';
import 'package:demo_sns_app/utils/firestore/items.dart';
import 'package:demo_sns_app/utils/firestore/rooms.dart';
import 'package:demo_sns_app/utils/firestore/users.dart';
import 'package:demo_sns_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/account.dart';
import '../../model/check_list.dart';

class ItemDetail extends StatefulWidget {
  final CheckList checkList;
  final Item item;
  const ItemDetail({Key? key, required this.checkList, required this.item}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  TextEditingController commentController = TextEditingController();
  Account myAccount = Authentication.myAccount!;

  @override
  Widget build(BuildContext context) {
    String imagePath = getImagePathFromType();
    return Scaffold(
      appBar: WidgetUtils.createAppBar(''),
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Image.asset(imagePath, height: 80)),
            Text(widget.item.content,  style: const TextStyle(fontSize: 18, color: Colors.black87)),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  Item updateItem = Item(
                      id: widget.item.id,
                      month: widget.item.month,
                      isComplete: widget.item.isComplete ? false : true,
                      content: widget.item.content,
                      checkListId: widget.item.checkListId,
                      hasComment: widget.item.hasComment,
                      completedTime: widget.item.isComplete ? null : Timestamp.now()
                  );
                  var result = await ItemFireStore.updateItem(updateItem, widget.checkList);
                  if (result) {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                child: widget.item.isComplete ? const Text('達成をキャンセル') : const Text('達成')
            ),
            const SizedBox(height: 30),
            const Divider(),
            Expanded(child: StreamBuilder<QuerySnapshot>(
              stream: RoomFirestore.rooms.doc(widget.checkList.roomId)
                .collection('check_lists').doc(widget.checkList.id)
                .collection('items').doc(widget.item.id)
                .collection('comments').orderBy('created_time', descending: false)
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
                                return myCommentWidget(context, comment, postAccount);
                              } else {
                                return someoneCommentWidget(context, comment, postAccount);
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
            ),
            textInputWidget(context)
          ],
        ),
      ),
    );
  }
  Container someoneCommentWidget(BuildContext context, Comment comment, Account postAccount) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80
            ),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5
                  )
                ]
            ),
            child: Text(comment.text, style: const TextStyle(color: Colors.black54)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: Text(DateFormat('yyyy/MM/dd').format(comment.createdTime.toDate())),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(postAccount.name),
          ),
        ],
      ),
    );
  }

  Container myCommentWidget(BuildContext context, Comment comment, Account postAccount) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80
            ),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5
                  )
                ]
            ),
            child: Text(comment.text, style: const TextStyle(color: Colors.white)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: Text(DateFormat('yyyy/MM/dd').format(comment.createdTime.toDate())),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(postAccount.name),
          ),
        ],
      ),
    );
  }

  String getImagePathFromType() {
    switch(widget.checkList.type) {
      case 0:
        return 'assets/images/hiyoko_run.png';
      case 1:
        return 'assets/images/hiyoko_crayon.png';
      case 2:
        return 'assets/images/hiyoko_voice.png';
      case 3:
        return 'assets/images/hiyoko_heart.png';
      default:
        return 'assets/images/hiyoko_dance.png';
    }
  }
  Container textInputWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(48),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  minLines: 1,
                  maxLines: 2,
                  controller: commentController,
                  decoration: const InputDecoration(
                      border: InputBorder.none
                  ),
                ),
              ),
            )
          ),
          IconButton(
            onPressed: () async {
              if (commentController.text.isNotEmpty) {
                Comment newComment = Comment(
                  text: commentController.text,
                  itemId: widget.item.id,
                  postAccountId: myAccount.id,
                  createdTime: Timestamp.now()
                );
                var commentAdd = await CommentFireStore.addComment(widget.checkList, newComment);
                if (commentAdd) {
                  Item updateItem = Item(
                      id: widget.item.id,
                      month: widget.item.month,
                      isComplete: widget.item.isComplete,
                      content: widget.item.content,
                      checkListId: widget.item.checkListId,
                      hasComment: true,
                      completedTime: widget.item.completedTime
                  );
                  var itemUpdated = await ItemFireStore.updateItem(updateItem, widget.checkList);
                  if (itemUpdated) {
                    commentController..clearComposing()..clear();
                    FocusScope.of(context).unfocus();
                  }
                }
              }
            },
            icon: const Icon(Icons.send),
            iconSize: 28,
            color: Colors.black54
          ),
        ],
      ),
    );
  }
}
