import 'package:google_fonts/google_fonts.dart';
import 'package:gutenberg_project/user.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;

import 'my_icons.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  String cardName;
  Details({
    Key? key,
    required this.cardName,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final TextEditingController _controller = TextEditingController();

  RefreshController refreshController = RefreshController();

  Books books = Books();

  List result = [];

  bool notFound = false;

  bool serch = false;
  String getVlaue = "";

  String link = "http://gutendex.com/books/?";
  int currentPage = 1;

//call future data from API and save data
  Future fetchdata(String subject) async {
    http.Response response;

    //FIrst time call api with cardname only show this filter book
    if (currentPage == 1 && !serch) {
      final uri = Uri.parse(link + subject);

      response = await http.get(uri);
      currentPage = 2;
    } else if (serch) {
      //in  serch book calling api cardname+serchbook  if only serch bar
      result.clear();

      final uri = Uri.parse(link + "search=" + getVlaue);

      setState(() {
        serch = !serch;
      });
      response = await http.get(uri);
    } else {
      //this api next page for scroll down page call next api
      final uri = Uri.parse(link);
      response = await http.get(uri);
    }

    //if api not same as previeus then call for solve multiple  sameresult
    // Books? books = Books();
    var body = response.body;
    Books books = Books.fromJson(jsonDecode(body));

    // print(books.count);
    // print(this.books.count);

    if (response.statusCode == 200 && books.next != this.books.next) {
      //decode responce from api
      this.books = books;

      // print(books.next);
      // print(books.previous);
      //serch result relativ book if not found below setstate call

      if (books.count == 0) {
        setState(() {
          notFound = !notFound;
        });
      } else {
        List<Results>? _results = books.results;
        for (var i in _results!) {
          // print(i);
          result.add(i);
        }
      }
      // print(result);

      return result;
    } else if (response.statusCode == 200) {
      return result;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: TextButton(
          onPressed: () {
            //clear data if back main page
            setState(() {
              result.clear();
              serch = !serch;
              currentPage = 1;
            });
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            iconBack,
            fit: BoxFit.contain,
          ),
        ),
        backgroundColor: const Color(0xffF8F7FF),
        iconTheme: const IconThemeData(color: Color(0xff5e56e7), size: 100),
        title: Text(
          widget.cardName,
          textAlign: TextAlign.start,
          style: GoogleFonts.montserrat(
              color: const Color(0xff5e56e7),
              fontWeight: FontWeight.w600,
              fontSize: 30),
        ),
      ),
      body: Container(
        color: const Color(0xffF8F7FF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    //on search set in api link search  value
                    setState(() {
                      serch = !serch;

                      link = "http://gutendex.com/books/?";
                      getVlaue = value;
                      if (value.isEmpty) {
                        result.clear();
                        serch = !serch;
                        currentPage = 1;
                      }

                      //clear all data only show search  relataed data
                    });
                  },
                  decoration: InputDecoration(
                      fillColor: const Color(0xffF0F0F6),
                      prefixIcon: SvgPicture.asset(
                        iconSearch,
                        fit: BoxFit.scaleDown,
                      ),
                      labelText: "Search",
                      labelStyle: GoogleFonts.montserrat(
                          color: const Color(0xffA0A0A0),
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0xff5e56e7),
                          )),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffF8F7FF)))),
                ),
              ),
            ),
            Expanded(
              //if after serch book not found show dialog box
              child: (notFound)
                  ? AlertDialog(
                      title: const Text("No Book Found"),
                      content: const Text("Pleasae Search With Another Key"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            //again start first
                            setState(() {
                              serch = !serch;
                              result.clear();
                              _controller.clear();
                              currentPage = 1;

                              notFound = !notFound;
                              fetchdata(widget.cardName);
                            });
                          },
                          child: const Text("Done"),
                        )
                      ],
                      elevation: 24,
                    )
                  : SmartRefresher(
                      enablePullUp: true,
                      enablePullDown: false,
                      controller: refreshController,
                      onLoading: () async {
                        setState(() {
                          //swip up load next page data
                          if (books.next != null) {
                            // print(books.next);
                            link = books.next!;

                            refreshController.loadComplete();
                          } else if (books.next == null) {
                            //if book not avalilable data load stop
                            refreshController.loadNoData();
                          }
                        });
                      },
                      child: Container(
                        color: const Color(0xffF0F0F6),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: FutureBuilder(
                            future: fetchdata(widget.cardName),
                            builder: (context, snaphot) {
                              List? data;
                              if (snaphot.hasData) {
                                data = snaphot.data as List;
                              }

                              //when data taking time show process

                              return (snaphot.hasData)
                                  ? GridView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 0.47,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height: 216,
                                          width: 152,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        offset: Offset(0, 2),
                                                        blurRadius: 5,
                                                        spreadRadius: 0,
                                                        color: Color.fromRGBO(
                                                            211, 209, 238, 0.5),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                          data![index]
                                                              .formats!
                                                              .imageJpeg
                                                              .toString(),
                                                        ))),
                                                height: 162,
                                                width: 114,
                                                child: GestureDetector(
                                                  //on book tap open redeble vieawer
                                                  onTap: () async {
                                                    var uri = data![index]
                                                        .formats!
                                                        .textHtml
                                                        .toString();
                                                    if (await canLaunch(uri)) {
                                                      await launch(
                                                        uri,
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                data[index].title.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: const Color(
                                                        0xff333333)),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                data[index]
                                                    .authors[0]!
                                                    .name
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: const Color(
                                                        0xffA0A0A0)),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: data!.length,
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    );
                            },
                          ),
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
