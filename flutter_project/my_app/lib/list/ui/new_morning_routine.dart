import 'package:flutter/material.dart';

class NewMorningRoutine extends StatefulWidget {
  const NewMorningRoutine({super.key});

  @override
  State<NewMorningRoutine> createState() => _NewMorningRoutineState();
}

class _NewMorningRoutineState extends State<NewMorningRoutine> {
  int selectedHour = 0;
  int selectedMinute = 0;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: false,
              title: const Text('Create New Routine'),
              content: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Автоматический размер
                      children: [
                        // Поле для ввода названия задачи
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Выбор времени
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Выпадающий список для часов
                            Column(
                              children: [
                                const Text('HR',
                                    style: TextStyle(fontSize: 16)),
                                DropdownButtonFormField<int>(
                                  value: selectedHour,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                  ),
                                  items: List.generate(25, (index) {
                                    return DropdownMenuItem(
                                      value: index,
                                      child: Text(index.toString()),
                                    );
                                  }),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedHour = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            // Выпадающий список для минут
                            Column(
                              children: [
                                const Text('MIN',
                                    style: TextStyle(fontSize: 16)),
                                DropdownButtonFormField<int>(
                                  value: selectedMinute,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                  ),
                                  items: List.generate(60, (index) {
                                    return DropdownMenuItem(
                                      value: index,
                                      child: Text(index.toString()),
                                    );
                                  }),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedMinute = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Кнопка подтверждения
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Закрываем диалог
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Задача создана: $selectedHour:${selectedMinute.toString().padLeft(2, '0')}',
                                ),
                              ),
                            );
                          },
                          child: const Text('Create Routine'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }
}
