import 'package:flutter/cupertino.dart';

class ArticleScreen extends StatefulWidget {
  final String time  ; 
  final String descri ; 
  final String titlee ; 
  final String picUrl ; 
  const ArticleScreen({
    super.key,required this.time ,
    required this.descri , 
    required this.titlee , 
    required this.picUrl , 

  
  });

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}