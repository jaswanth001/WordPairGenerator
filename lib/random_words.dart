import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  final _randomwordpairs = <WordPair>[];
  final _savedwordpairs =Set<WordPair>();
  Widget _buildList(){
    return ListView.builder(
  padding: const EdgeInsets.all(16.0),
  itemBuilder: (context, item){
    if(item.isOdd) return Divider();

    final index = item ~/ 2;

    if(index>=_randomwordpairs.length){
      _randomwordpairs.addAll(generateWordPairs().take(10));
    }
    return _buildRow(_randomwordpairs[index]);
  }
);
  }

  Widget _buildRow(WordPair pair){
    final alreadySaved = _savedwordpairs.contains(pair); 
    return ListTile(
      title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0)),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border),
      onTap: () {
        setState(() {
          if(alreadySaved){
            _savedwordpairs.remove(pair);
          } else{
            _savedwordpairs.add(pair);
          }
        });
      },
    );
  }


  void _pushedSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedwordpairs.map((WordPair pair) {
        return ListTile(
            title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)));
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: Text('Saved WordPairs')),
          body: ListView(children: divided));
    }));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("WordPair Generator"),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.list), onPressed: _pushedSaved) 
      ],
      ),
      body: _buildList()
    );

  }
}