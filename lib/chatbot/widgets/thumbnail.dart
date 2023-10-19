import 'package:flutter/material.dart';

class ThumbnailChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(108, 0, 0, 0),
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                width: 50.0,
                                height: 50,
                                child: Image.asset(
                                  "assets/qx-logo-1r.png",
                                  fit: BoxFit.cover,
                                ))),
                      ),
                    );
                  }),
            )));
  }
}