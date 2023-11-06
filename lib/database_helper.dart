import 'package:path_provider/path_provider.dart';
import 'dart:io'as  io;
import 'package:shoping_cart/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
class DBHelper{
  static Database? _db;
  Future<Database?> get db async{
    if(_db!=null){
     return  _db!;
    }_db= await initDatabase();
}
 initDatabase() async{
    io.Directory documentDirectory= await getApplicationDocumentsDirectory();
    String path=join(documentDirectory.path, 'cart.db');
    var db= await openDatabase(path,version: 1,onCreate: _onCreate,);
    return db;
 }
 _onCreate(Database db, int version)async{
    await 
   db.execute('CREATE TABLE cart(id INTEGER PRIMARY KEY,productId VARCHAR UNIQUE,productName TEXT, initialPrice INTEGER,productPrice INTEGER,quantity INTEGER,unitTag TEXT,image TEXT)');

    Future<Cart>insert(Cart cart)async{
      var dbclient=await db;
     await dbclient!.insert('cart',cart.toMap());
     return cart;
    }
 }

   insert(Cart cart) {}



}


