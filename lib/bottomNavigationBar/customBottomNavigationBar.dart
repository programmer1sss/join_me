import 'package:flutter/material.dart';


class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({ Key? key,this.defaultSelectedIndex = 0,required this.onChange, }) : super(key: key);
  final int defaultSelectedIndex;
  final Function(int) onChange;

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildNavBarItem(Icons.map, 0, ),
          buildNavBarItem(Icons.list, 1, ),
          buildNavBarItem(Icons.add, 2, ),
          buildNavBarItem(Icons.settings, 3, ),   
        ],
      );
      
  }
  GestureDetector buildNavBarItem(IconData icon, int index, ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onChange(index);
          _selectedIndex = index;
        });
      },
      child: 
      Container(
        height: 60,
        // padding: EdgeInsets.all(10),
        
        width: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
         color: Colors.white,
          border: Border.all(
            color: index == _selectedIndex ? Colors.black : Colors.grey,
            width: index == _selectedIndex ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 30,
        ),
      ),
    );
  }
}