import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  String route;
  String filter;
  String image;
  Color backgroundColor;
  CustomButton(this.route, this.filter, this.image, this.backgroundColor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Container(
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            children: [
              ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          route,
                          arguments:{
                            'filter':filter,
                          });
                    },
                    child: Text(filter),
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerRight,
                  primary: backgroundColor,
                  fixedSize: const Size(250, 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                      ),
                  padding: const EdgeInsets.only(right: 35),
                )
                ),
              Positioned(
                top: 0,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        route,
                        arguments:{
                          'filter':filter,
                        });
                  },
                  iconSize: 125,
                  color: Colors.transparent,
                  icon: Image.asset(image, width: 150, height: 150),
                ),
              ),
            ],
          ),
        ),
      );
  }
}