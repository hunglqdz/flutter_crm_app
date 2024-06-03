import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  final void Function()? onTap;

  const ItemWidget({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        margin: const EdgeInsets.all(15),
        elevation: 5,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                item.imagePath,
                width: 200,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '${item.price.toString()} VND',
                  style: const TextStyle(color: Colors.orange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
