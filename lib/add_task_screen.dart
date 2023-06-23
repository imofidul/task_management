import 'package:elred_todo/task_model.dart';
import 'package:elred_todo/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOrUpdateTaskScreen extends StatefulWidget {
  final TaskModal? taskModal;
  const AddOrUpdateTaskScreen({super.key,this.taskModal});

  @override
  _AddOrUpdateTaskScreenState createState() => _AddOrUpdateTaskScreenState();
}

class _AddOrUpdateTaskScreenState extends State<AddOrUpdateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  String _selectedType = 'Business';
  DateTime _selectedDate = DateTime.now();

   List<String> _types = ['Business', 'Personal',];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  void initTaskDetails(){
    if(widget.taskModal!=null)
      {
        _name=widget.taskModal?.name??"";
        _selectedDate=DateTime.fromMillisecondsSinceEpoch(widget.taskModal?.date??233);
        _description=widget.taskModal?.description??"";
        _selectedType=widget.taskModal?.type??"Personal";
        setState(() {

        });
      }
  }

  @override
  void initState() {
    super.initState();
    initTaskDetails();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff555b95),
      appBar: AppBar(
        backgroundColor:  const Color(0xff555b95),
        title: const Text('Add New Thing',style: TextStyle(color: Colors.white),),
        actions:  [
          if(widget.taskModal!=null)
          GestureDetector(child: const Icon(Icons.delete),onTap: (){
            context.read<TaskProvider>().deleteTask(widget.taskModal!);
            exitScreen();
          },),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name',hintStyle:TextStyle(color: Colors.white),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value ?? '';
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value ?? '';
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Type'),
                value: _selectedType,
                onChanged: (value) {
                  setState(() {
                    _selectedType = value.toString();
                  });
                },
                items: _types.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type??""),
                  );
                }).toList(),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Date'),
                subtitle: Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if(widget.taskModal==null)
                      {
                        addTask();
                        exitScreen();
                      }
                    else{
                      updateTask();
                      exitScreen();
                    }

                  }
                },
                child: const Text('Add your thing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void exitScreen(){
      Future.delayed(Duration(microseconds: 200),(){
        Navigator.of(context).pop();
      });
  }
  void addTask()async{
    TaskModal taskModal=TaskModal();
    taskModal.name=_name;
    taskModal.type=_selectedType;
    taskModal.description=_description;
    taskModal.date=_selectedDate.millisecondsSinceEpoch;
    await context.read<TaskProvider>().saveTask(taskModal);

  }
  void updateTask()async{
    TaskModal taskModal=widget.taskModal!;
    taskModal.name=_name;
    taskModal.type=_selectedType;
    taskModal.date=_selectedDate.millisecondsSinceEpoch;
    taskModal.description=_description;
    taskModal.id=widget.taskModal!.id!;
    await context.read<TaskProvider>().updateTask(taskModal);

  }
}