import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier{
int _counter=0;
int get counter=>_counter;

double _totalprice=0.0;
double get totalprice=>_totalprice;

void _setPrefItem()async{
  SharedPreferences pref= await SharedPreferences.getInstance();
  pref.setInt('cart_item', _counter);
  pref.setDouble('total_price', _totalprice);
  notifyListeners();

}
void _getPrefItem()async{
  SharedPreferences pref= await SharedPreferences.getInstance();
  _counter=pref.getInt('cart_item')??0;
  _totalprice=pref.getDouble('total_price')??0;
  notifyListeners();

}
void Addcounter(){
  _counter++;
  _setPrefItem();
  notifyListeners();
}
void removecounter(){
  _counter--;
  _setPrefItem();
  notifyListeners();
}
 int getcounter(){
  _getPrefItem();
  return  _counter;
 }

void AddTotalPrice(double Productprice ){
  _totalprice=totalprice+Productprice;
  _setPrefItem();
 notifyListeners();
}
void removeTotalPrice(double Productprice){
  _totalprice=totalprice-Productprice;
  _setPrefItem();
  notifyListeners();
}
double getTotalPrice(){
  _getPrefItem();
  return  _totalprice;
}
}