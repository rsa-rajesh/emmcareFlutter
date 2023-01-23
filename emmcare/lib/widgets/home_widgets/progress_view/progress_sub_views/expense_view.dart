import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({super.key});

  @override
  State<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor, 
        actions: [
          InkWell(
              onTap: () {},
              splashColor: Colors.lightBlueAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.save),
                    SizedBox(
                      width: 10,
                    ),
                    Center(child: Text("Save")),
                  ],
                ),
              ))
        ],
        automaticallyImplyLeading: true,
        title: Text(
          "Add Expense",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Card(
          child: Wrap(
            children: [
              InkWell(
                onTap: () {},
                splashColor: Colors.lightBlueAccent,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.white70,
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                            'https://scontent.fktm1-1.fna.fbcdn.net/v/t39.30808-6/275607503_275772231373960_2730988905792695328_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=d_t10sug3RAAX8VaGpZ&_nc_oc=AQkE5mTZPAqfb7uqqLCKFmufsvujvgX5CTNpMnhzEMBqwcDrpxKyvFj6gdv8qSb8QUo&_nc_ht=scontent.fktm1-1.fna&oh=00_AfCZAC7zY_IZAMei-H8mgkh2goTBNN_FCwmZFQcgLWfK7w&oe=63D1D959'),
                        backgroundColor: Colors.transparent,
                      ),
                      subtitle: Text(
                        "UPLOAD IMAGE",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Enter Expense",
                    isDense: true,
                    prefixIcon: Text(
                      "\$" + "\$",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.notifications, size: 30),
                    Text(
                      "Name of Client",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Divider(height: 5),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 6),
                child: TextFormField(
                  maxLines: null,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: "Your Note",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    hintMaxLines: 5,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
