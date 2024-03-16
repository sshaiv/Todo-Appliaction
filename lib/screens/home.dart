import 'package:flutter/material.dart';
import 'package:reminder/constants/colors.dart';
import 'package:reminder/widgets/ToDo_item.dart';

import '../model/Todo.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

 @override
void initState() {
  _foundToDo=todoList;
  super.initState();
  
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: Text(
                        'All DO TO\'s ',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                    ),
                    for (ToDo todoo in _foundToDo.reversed) 
                    ToDoItem(
                      todo: todoo, onToDoChange: _handleToDoChange,
                      onDeleteItem: _deleToDoItem,
                  
                ),
                ],
                ),
              ),
            ]),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                   
                    bottom: 20,
                   right: 20, 
                  left: 20),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  vertical: 5,
                  ),
                   decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow:const [BoxShadow(color: Colors.grey,offset: Offset(0.0,0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                    ),],
                    borderRadius: BorderRadius.circular(10),
                   ),
                   child: TextField(
                    controller:_todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      border: InputBorder.none,
                    ),
                   ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20,
                right: 20,
                ),
                child: ElevatedButton(
                  // child: Text('+',style:TextStyle(fontSize: 40,) ,
                  // ),
                  child: Icon(Icons.arrow_circle_right_rounded),
                onPressed: (){
                  _addToDoItem(_todoController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: tdBlue,
                  minimumSize: Size(60,60),
                  elevation: 10,
                ),
                ),
              )
            ]),
          ),
        
        ],
      ),
    );
  }


void _handleToDoChange(ToDo todo){
  setState(() {
      todo.isDone = !todo.isDone;
  });

}

void _deleToDoItem(String id){
  setState(() {
    todoList.removeWhere((item) => item.id==id);

  });
}

void _addToDoItem(String toDO){
  setState(() {
      todoList.add(ToDo(id: DateTime.now().microsecondsSinceEpoch.toString(), todoText:toDO ),);

  });
  _todoController.clear();
}

void _runFilter(String enterKeyword){
  List<ToDo> results =[];
  if(enterKeyword.isEmpty){
    results=todoList;
  }
  else{
    results=todoList.where((item) => item.todoText!.toLowerCase().contains(enterKeyword.toLowerCase())).toList();
  }
  setState(() {
    _foundToDo=results;
  });
}

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value)=>_runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          CircleAvatar(
            child: Image(
              
              image: AssetImage('assets/images/avatar.jpeg'),
            ),
          ),
        ],
      ),
    );
  }
}
