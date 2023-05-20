import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/homepage.dart';
import 'package:food_delivery_app/widget/mybutton.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 250,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTile(
              leading: const Text(
                "Total",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "\$50",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            MyButton(
              name: "Order",
              onPressed: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomePage(),
              ),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Check Out",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 70,
                child: Center(
                  child: ListTile(
                    leading: const CircleAvatar(
                      maxRadius: 25,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("images/chicken.png"),
                    ),
                    title: const Row(
                      children: [
                        Text("x1"),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Chicken",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Star Hotel ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Rs 200",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 70,
                child: Center(
                  child: ListTile(
                    leading: const CircleAvatar(
                      maxRadius: 25,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("images/chicken.png"),
                    ),
                    title: const Row(
                      children: [
                        Text("x1"),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Chicken",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Star Hotel ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Rs 200",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
