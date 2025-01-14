import 'package:checklist_child_grow_up/view/about/about_account_menus_page.dart';
import 'package:checklist_child_grow_up/view/about/about_app_menus_page.dart';
import 'package:checklist_child_grow_up/view/about/about_check_list_page.dart';
import 'package:checklist_child_grow_up/view/about/about_room_menus_page.dart';
import 'package:flutter/material.dart';

import '../../model/check_list.dart';

class CheckListPageActionMenus extends StatefulWidget {
  final String childName;
  final String roomId;

  const CheckListPageActionMenus(
      {Key? key, required this.childName, required this.roomId})
      : super(key: key);

  @override
  State<CheckListPageActionMenus> createState() =>
      _CheckListPageActionMenusState();
}

class _CheckListPageActionMenusState extends State<CheckListPageActionMenus> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: PopupMenuButton<CheckListPopupMenuItem>(
        onSelected: (CheckListPopupMenuItem value) {
          switch (value) {
            case CheckListPopupMenuItem.aboutCheckList:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AboutCheckListPage();
              }));
              break;
            case CheckListPopupMenuItem.aboutRoom:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AboutRoomMenusPage(
                    childName: widget.childName, roomId: widget.roomId);
              }));
              break;
            case CheckListPopupMenuItem.aboutAccount:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AboutAccountMenusPage();
              }));
              break;
            case CheckListPopupMenuItem.aboutApp:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AboutAppMenusPage();
              }));
              break;
            default:
              break;
          }
        },
        itemBuilder: (context) => <PopupMenuEntry<CheckListPopupMenuItem>>[
          PopupMenuItem(
              value: CheckListPopupMenuItem.aboutCheckList,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 14.0),
                    child: Icon(Icons.checklist),
                  ),
                  Text('成長のチェックリストについて',
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              )),
          const PopupMenuDivider(),
          PopupMenuItem(
              value: CheckListPopupMenuItem.aboutRoom,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 14.0),
                    child: Icon(Icons.meeting_room),
                  ),
                  Text('ルームについて', style: Theme.of(context).textTheme.bodyLarge),
                ],
              )),
          const PopupMenuDivider(),
          PopupMenuItem(
              value: CheckListPopupMenuItem.aboutAccount,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 14.0),
                    child: Icon(Icons.account_circle),
                  ),
                  Text('アカウントについて',
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              )),
          const PopupMenuDivider(),
          PopupMenuItem(
              value: CheckListPopupMenuItem.aboutApp,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 14.0),
                    child: Icon(Icons.info),
                  ),
                  Text('アプリについて', style: Theme.of(context).textTheme.bodyLarge),
                ],
              )),
        ],
        offset: const Offset(0.0, 60.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Icon(Icons.menu, size: 34.0, color: Colors.black87),
      ),
    );
  }
}
