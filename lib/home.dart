import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gutenberg_project/my_icons.dart';
import 'package:gutenberg_project/next_page.dart';

class Gutenberg extends StatefulWidget {
  const Gutenberg({Key? key}) : super(key: key);

  @override
  _GutenbergState createState() => _GutenbergState();
}

class _GutenbergState extends State<Gutenberg> {
  //Cardname as given list
  final List cardName = [
    'Fiction',
    'Drama',
    'Humor',
    'Politics',
    'Philosophy',
    'History',
    'Adventure',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(children: [
          SvgPicture.asset(
            iconPattern,
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Gutenberg\nProject",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff5e56e7),
                      fontSize: 48),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "A social cataloging website that allows you to freely search its database of books,\nannotations, and reviews.",
                  style: GoogleFonts.montserrat(
                      color: const Color(0xff333333), fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),

                //Listview using cardname
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemExtent: 66,
                    shrinkWrap: true,
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 5,
                            spreadRadius: 0,
                            color: Color.fromRGBO(211, 209, 238, 0.5),
                          )
                        ]),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ListTile(
                              leading: SvgPicture.asset(
                                'assets/images/${cardName[index]}.svg',
                                height: 50,
                              ),
                              trailing: SvgPicture.asset(iconNext),
                              onTap: () {
                                //navigate card name as subjact og book go next page

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Details(
                                              cardName: cardName[index],
                                            )));
                              },
                              title: Text(
                                cardName[index].toString().toUpperCase(),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xff333333),
                                  fontSize: 25,
                                  fontStyle: FontStyle.normal,
                                ),
                              )),
                        ),
                      );
                    })
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
