import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        transform: GradientRotation(20),
                        colors: [
                          Colors.green,
                          Colors.green,
                          Colors.green,
                          Colors.greenAccent,
                          Colors.greenAccent,
                        ])),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              // color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          '100 €',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Acoumpt',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              // color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          '100 €',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Discount',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              // color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          '100 €',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              // color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          '100 €',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 90,
                left: -20,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
              ),
              Positioned(
                bottom: 90,
                right: -20,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: 115,
                child: Row(
                  children: [
                    ...List.generate(
                      500 ~/ 10,
                      (index) {
                        return Expanded(
                          child: Container(
                            // width: 2,
                            height: 2,
                            decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.white,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(5)),
            child: const Text(
              'Pay',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
