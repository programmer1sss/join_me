import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTypeSelection extends StatelessWidget {
  const MapTypeSelection({
    Key? key,
    required List mapThemes,
    required Completer<GoogleMapController> controller,
  }) : _mapThemes = mapThemes, _controller = controller, super(key: key);

  final List _mapThemes;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 160,
      right: 15,
      child: Container(
          width: 35,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const Text(
                            //   "Select Theme",
                            //   style: TextStyle(
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.w600,
                            //       fontSize: 18),
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 100,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _mapThemes.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: 
                                      () async {
                                        final GoogleMapController controller =
                                            await _controller.future;
                                        controller.setMapStyle(
                                            _mapThemes[index]['style']);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 100,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  _mapThemes[index]['image']),
                                            )),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )),
                  );
                },
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.layers_rounded, size: 25),
              ),
            ],
          )),
    );
  }
}