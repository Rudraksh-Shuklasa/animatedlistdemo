import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main()=>runApp(MyApp());
class AnimatedListDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return AnimatedListWidget();
  }


}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated ListView',
      home: AnimatedListDemo(),
    );
  }
}
class AnimatedListWidget extends State<AnimatedListDemo>{
  final GlobalKey<AnimatedListState> _key=GlobalKey();

  List<String> _data = [
    WordPair.random().toString(),
    WordPair.random().toString(),
    WordPair.random().toString(),
    WordPair.random().toString(),
    WordPair.random().toString(),
  ];
  void _addAnItem() {
    _data.insert(0,  WordPair.random().toString());
    _key.currentState.insertItem(0);
  }

  void _deleteAnItem() {
    String removeItem=_data[0];

    _key.currentState.removeItem(
      0,
          (BuildContext context, Animation<double> animation) => _buildItem(context, removeItem, animation),
      duration: const Duration(milliseconds: 250),
    );

    _data.removeAt(0);

  }

  void _deleteAllAnItem() {
    final itemCount=_data.length;

    for(var i =0;i<itemCount;i++){
      String itemToRemove=_data[0];
      _key.currentState.removeItem(0,
            (BuildContext context, Animation<double> animation) => _buildItem(context, itemToRemove, animation),
        duration: const Duration(milliseconds: 250),
      );

      _data.removeAt(0);
    }
  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
       title: new Text('Animated List'),
       backgroundColor: Colors.orange,
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          child: Text('Add Random',   style: TextStyle(fontSize: 20, color: Colors.white),),
          onPressed: (){
            _addAnItem();
          },
        ),
        RaisedButton(
          child: Text('Delete Item',   style: TextStyle(fontSize: 20, color: Colors.white),),
          onPressed: (){
            _deleteAnItem();
          },
        ),
        RaisedButton(
          child: Text('delete all',   style: TextStyle(fontSize: 20, color: Colors.white),),
          onPressed: (){
            _deleteAllAnItem();
          },
        ),
      ],

      body: AnimatedList(
           key: _key,
          initialItemCount: _data.length,
          itemBuilder: (context,index,animation)=> _buildItem(context, _data[index], animation)
      ),
    );



  }




  
  

}

Widget _buildItem(BuildContext context, String item, Animation<double> animation) {
    TextStyle textStyle=TextStyle(fontSize: 20);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
        child: SizedBox(
          height: 50.0,
          child: Card(
            child: Center(
              child: Text(item, style: textStyle),
            ),
          ),
        ),
      ),
    );


}
