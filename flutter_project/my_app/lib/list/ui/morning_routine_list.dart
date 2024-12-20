import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/data/activities_data/fire_and_ice_state.dart';
import 'package:my_app/list/models/morning_routine_model.dart';
import 'package:my_app/list/service/morning_routine_service.dart';
import '../../routing/app_routing.dart';

class MorningRoutineList extends ConsumerStatefulWidget {
  const MorningRoutineList({super.key});

  @override
  ConsumerState<MorningRoutineList> createState() => _MorningRoutineListState();
}

class _MorningRoutineListState extends ConsumerState<MorningRoutineList> {
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
    if (routines != null) {
      setState(() {
        items = routines
            .map((routine) => {
                  'id': routine.id,
                  'checkbox': routine.checkbox,
                  'title': routine.title,
                  'hour': routine.hour,
                  'minute': routine.minute,
                  'user': routine.user,
                })
            .toList();
      });
      return routines;
    } else {
      return [];
    }
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
                      !snapshot.hasData || snapshot.data!.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'No routines',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ReorderableListView(
                              buildDefaultDragHandles: false,
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              physics: const NeverScrollableScrollPhysics(),
                              onReorder: (int oldIndex, int newIndex) {
                                setState(() {
                                  if (newIndex > oldIndex) newIndex--;
                                  final item = items.removeAt(oldIndex);
                                  items.insert(newIndex, item);
                                });
                              },
                              children: [
                                for (int index = 0;
                                    index < items.length;
                                    index++)
                                  Container(
                                    key: ValueKey(index),
                                    margin: const EdgeInsets.only(
                                        bottom: 6, top: 6),
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
                                        onTap: () async {
                                          // Переключаем состояние checkbox
                                          setState(() {
                                            items[index]['checkbox'] =
                                                !items[index]['checkbox'];
                                          });

                                          // Обновляем состояние fire
                                          ref
                                              .read(fireAndIceProvider.notifier)
                                              .plusToFire(
                                                items[index]['checkbox']
                                                    ? 50
                                                    : -50,
                                              );

                                          // Обновляем данные в базе
                                          try {
                                            final updatedRoutine =
                                                MorningRoutineModel(
                                              id: items[index]['id'] as String,
                                              checkbox: items[index]['checkbox']
                                                  as bool,
                                              title: items[index]['title']
                                                  as String,
                                              hour: items[index]['hour'] as int,
                                              minute:
                                                  items[index]['minute'] as int,
                                              user: items[index]['user']
                                                  as String,
                                            );

                                            await MorningRoutineService()
                                                .updateMorningRoutine(
                                                    updatedRoutine);
                                            print(
                                                "Routine updated successfully!");
                                          } catch (e) {
                                            print("Error updating routine: $e");
                                          }
                                        },
                                        child: ListTile(
                                          key: ValueKey(index),
                                          horizontalTitleGap: 12.0,
                                          trailing:
                                              ReorderableDragStartListener(
                                            index: index,
                                            child: const Icon(
                                                Icons.drag_indicator),
                                          ),
                                          leading: Checkbox(
                                            value: items[index]['checkbox']
                                                as bool?,
                                            onChanged: (value) async {
                                              setState(() {
                                                items[index]['checkbox'] =
                                                    value;
                                              });

                                              // Создаём объект MorningRoutineModel с обновлёнными данными
                                              MorningRoutineModel
                                                  updatedRoutine =
                                                  MorningRoutineModel(
                                                id: items[index]['id']
                                                    as String,
                                                checkbox: value,
                                                title: items[index]['title']
                                                    as String,
                                                hour:
                                                    items[index]['hour'] as int,
                                                minute: items[index]['minute']
                                                    as int,
                                                user: items[index]['user']
                                                    as String,
                                              );

                                              // Вызываем метод для обновления в базе данных
                                              try {
                                                await MorningRoutineService()
                                                    .updateMorningRoutine(
                                                        updatedRoutine);
                                                print(
                                                    "Routine updated successfully!");
                                              } catch (e) {
                                                print(
                                                    "Error updating routine: $e");
                                              }
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
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: Text(
                                                  '${items[index]['hour'].toString().padLeft(2, '0')}:${items[index]['minute'].toString().padLeft(2, '0')} PM',
                                                  style: TextStyle(
                                                    decoration: items[index]
                                                            ['checkbox']
                                                        ? TextDecoration
                                                            .lineThrough
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
                                          NavRoutes.create_morning_routine.name,
                                          extra: items.length),
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
