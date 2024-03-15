import 'package:flutter/material.dart';

class Todo {
  String text;
  bool isCompleted;

  Todo({
    required this.text,
    this.isCompleted = false,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];

  void deletetarefa(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void toggleCompletion(int index) {
    setState(() {
      todos[index].isCompleted = !todos[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('To-do List'),
        backgroundColor:  Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoController,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Adicionar tarefa',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      String text = todoController.text.trim();
                      if (text.isNotEmpty) {
                        setState(() {
                          todos.add(Todo(text: text));
                          todoController.clear();
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Campo vazio, por favor, insira um texto válido.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: const Text('+', style: TextStyle(fontSize: 30)),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(50, 65),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      tileColor: todos[index].isCompleted ? Colors.green : Colors.red,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(todos[index].text),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  toggleCompletion(index);
                                },
                                icon: Icon(Icons.check),
                              ),
                              IconButton(
                                onPressed: () {
                                  deletetarefa(index);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        print('Tarefa: ${todos[index].text}');
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text('Você possui ${todos.length} tarefas pendentes', style: TextStyle(color: Colors.white),),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        todos.clear();
                      });
                    },
                    child: const Text('Limpar tudo'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Fim'),
          ],
        ),
      ),
    );
  }
}
