import 'package:farmconnect/customer_side/view/screen/details/widgets/seach_product_screen.dart';
import 'package:flutter/material.dart';

class TwoInnerHeaderWigets extends StatelessWidget {
  const TwoInnerHeaderWigets({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.17,
      child: Stack(
        children: [
          Image.asset(
            "assets/icons/header_farm.jpg",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 20,
            top: 65,
            child: SizedBox(
              width: 320,
              height: 50,
              child: TextField(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SearchProductScreen();
                      },
                    ),
                  );
                },
                decoration: InputDecoration(
                  hintText: "Search for Farm Products",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7F7F7F),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  prefixIcon: Image.asset("assets/icons/searc1.png"),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  focusColor: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            left: 351,
            top: 72,
            child: Material(
              type: MaterialType.transparency,
              // color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Ink(
                  width: 31,
                  height: 31,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/bell.png"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //   left: 394,
          //   top: 82,
          //   child: Material(
          //     type: MaterialType.transparency,
          //     child: InkWell(
          //       onTap: () {},
          //       child: Ink(
          //         width: 31,
          //         height: 31,
          //         decoration: BoxDecoration(
          //           image: DecorationImage(
          //             image: AssetImage("assets/icons/message.png"),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
