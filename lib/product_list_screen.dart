import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:shoping_cart/cart_provider.dart';
import 'package:shoping_cart/database_helper.dart';
import 'database_helper.dart';
import 'package:shoping_cart/model.dart';
class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}
DBHelper dbHelper=DBHelper();

class _ProductListState extends State<ProductList> {
  List<String> productName=['Banana','Orange','Mango','Graps','Shuger','Tomato'];
  List<String> productUnit=['Dozen','Dozen','kg','KG','KG',"KG"];
  List<int> productPrice=[300,160,200,160,100,80];
  List<String> productPicture=[
                  'https://images.pexels.com/photos/365810/pexels-photo-365810.jpeg?auto=compress&cs=tinysrgb&w=600',
                   'https://images.pexels.com/photos/161559/background-bitter-breakfast-bright-161559.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhfdEIz0FMbT06oqEXsBo8_zJrFHedcL0o58eNT7VGoXvmjb-I_wY0spmVbFlX88hr3tg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLiyjaxtN9UfSEC-ezFESh814MtQGHkpvvUw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZn99cchg41bWTzX0CZySGd8AI4awq3I_krSQy21KEcG7qtXm89F24fWBZS8SG3cjya0c&usqp=CAU',
     'https://thumbs.dreamstime.com/b/tomatoes-half-tomato-isolated-white-136961939.jpg',
      ];

  @override
  Widget build(BuildContext context) {
 final  cart=Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(

        title: Text("Product List "),
        centerTitle: true,
        actions: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 13.0),
            child: Badge(
              badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(value.getcounter().toString(),style: TextStyle(color: Colors.white),);
                  }),

              child: Icon(Icons.shopping_bag_outlined),
            ),
          )
        ],
      ),
      body:Center(
        child: Expanded(
          child: ListView.builder(
             itemCount:productName.length,
            itemBuilder: ((context, index) {
              return Card(
                child: Column(


                  children: [
                    Row(
                      children: [
                        Image(
                            height: 100,
                            width: 100,
                            image: NetworkImage(productPicture[index].toString())),
                        SizedBox(width: 7,),
                        Expanded(
                          child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productName[index].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 0),
                              Text(productUnit[index].toString()+" "+"R.S"+productPrice[index].toString(),
                                style: TextStyle(),),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomRight,
                                child:   InkWell(
                                  onTap: (){

                                   dbHelper.insert(
                                        Cart(id: index,
                                            productId: index.toString(),
                                            productName: productName[index].toString(),
                                            initialPrice: productPrice[index],
                                            producPrice: productPrice[index],
                                            quantity: 1,
                                            unitTag: productUnit[index],
                                            image: productPicture.toString())

                                   ).then((value){
                                      cart.AddTotalPrice(double.parse(productPrice[index].toString()));
                                      cart.Addcounter();
                                   }).onerror((error ,stackTrace){
                                        print(error.toString());
                                   });
                                  },

                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.green,
                                    ),
                                    child: Text('Add to Cart'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              );
            })),
        ),
      ),

    );
  }
}
