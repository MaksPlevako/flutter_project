import 'package:flutter/material.dart';

class MorningRoutineList extends StatefulWidget {
  const MorningRoutineList({super.key});

  @override
  State<MorningRoutineList> createState() => _MorningRoutineListState();
}

class _MorningRoutineListState extends State<MorningRoutineList> {
  List<Map<String, dynamic>> items = [
    {
      'checkbox': true,
      'title': "Shower",
      'hour': 7,
      'minute': 30,
    },
    {
      'checkbox': false,
      'title': "Brushtalk",
      'hour': 8,
      'minute': 0,
    },
    {
      'checkbox': false,
      'title': "Meditation",
      'hour': 6,
      'minute': 30,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 1.1,
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        collapsedShape:
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: const Text(
          "Morning Routine",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
        ),
        children: [
          ReorderableListView(
            shrinkWrap: true,
            clipBehavior: Clip.none,
            padding: const EdgeInsets.only(left: 12, right: 12),
            physics: const NeverScrollableScrollPhysics(),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final item = items.removeAt(oldIndex);
                items.insert(newIndex, item);
              });
            },
            children: [
              for (int index = 0; index < items.length; index++)
                Container(
                  key: ValueKey(index),
                  margin: const EdgeInsets.only(bottom: 6, top: 6),
                  decoration: BoxDecoration(
                    color: items[index]['checkbox']
                        ? Colors.orange
                        : Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          items[index]['checkbox'] = !items[index]['checkbox'];
                        });
                      },
                      child: ListTile(
                        key: ValueKey(index),
                        horizontalTitleGap: 12.0,
                        leading: Checkbox(
                          value: items[index]['checkbox'],
                          onChanged: (value) {
                            setState(() {
                              items[index]['checkbox'] = value;
                            });
                          },
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                items[index]['title'],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                '${items[index]['hour'].toString().padLeft(2, '0')}:${items[index]['minute'].toString().padLeft(2, '0')} PM',
                                style: TextStyle(
                                  decoration: items[index]['checkbox']
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
