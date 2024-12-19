import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/list/models/morning_routine_model.dart';
import 'package:my_app/list/service/morning_routine_service.dart';
import '../../routing/app_routing.dart';

class MorningRoutineList extends StatefulWidget {
  const MorningRoutineList({super.key});

  @override
  State<MorningRoutineList> createState() => _MorningRoutineListState();
}

class _MorningRoutineListState extends State<MorningRoutineList> {
  final MorningRoutineService _service = MorningRoutineService();
  late Future<List<MorningRoutineModel>> _futureRoutines;
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    _futureRoutines = _fetchRoutines();
  }

  Future<List<MorningRoutineModel>> _fetchRoutines() async {
    final routines = await _service.getAllMorningRoutines();
    setState(() {
      items = routines
          .map((routine) => {
                'id': routine.id,
                'checkbox': routine.checkbox,
                'title': routine.title,
                'hour': routine.hour,
                'minute': routine.minute,
              })
          .toList();
    });
    return routines;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MorningRoutineModel>>(
      future: _futureRoutines,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Ошибка: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Нет данных для отображения"));
        }

        return Container(
          width: MediaQuery.sizeOf(context).width / 1.1,
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              ExpansionTile(
                backgroundColor: Colors.white,
                collapsedBackgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                collapsedShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                title: const Text(
                  "Morning Routine",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                ),
                children: [
                  Column(
                    children: [
                      ReorderableListView(
                        buildDefaultDragHandles: false,
                        shrinkWrap: true,
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
                                      items[index]['checkbox'] =
                                          !items[index]['checkbox'];
                                    });
                                  },
                                  child: ListTile(
                                    key: ValueKey(index),
                                    horizontalTitleGap: 12.0,
                                    trailing: ReorderableDragStartListener(
                                      index: index,
                                      child: const Icon(Icons.drag_indicator),
                                    ),
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
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            '${items[index]['hour'].toString().padLeft(2, '0')}:${items[index]['minute'].toString().padLeft(2, '0')} PM',
                                            style: TextStyle(
                                              decoration: items[index]
                                                      ['checkbox']
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
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: Colors.grey.shade50, width: 1),
                                    right: BorderSide(
                                        color: Colors.grey.shade50, width: 1),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () => context.pushNamed(
                                          NavRoutes
                                              .create_morning_routine.name, extra: items.length),
                                      child: const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(width: 12),
                                            Text(
                                              'Add Task',
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: Colors.grey.shade50, width: 1),
                                    left: BorderSide(
                                        color: Colors.grey.shade50, width: 1),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () => print('Manage'),
                                      child: const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.edit_outlined,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(width: 12),
                                            Text(
                                              'Manage',
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
