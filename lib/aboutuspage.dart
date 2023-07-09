  import 'dart:collection';
  import 'package:flutter/foundation.dart';
  import 'package:flutter/material.dart';

  /*class AboutUsPage extends StatelessWidget {
    final String url;

    const AboutUsPage({Key? key, required this.url}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('About Us'),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
          initialUserScripts: UnmodifiableListView([
            UserScript(source: """
              var header = document.querySelector(#maincontent > div.columns > div > div:nth-child(7) > div:nth-child(1) > div.stricky-header.stricked-menu.main-menu.stricky-fixed > div > div > div.main-menu__wrapper-inner); // use here the correct CSS selector for your use case
              if (header != null) {
                header.remove(); // remove the HTML element. Instead, to simply hide the HTML element, use header.style.display = 'none';
              }
              var footer = document.querySelector(#maincontent > div.columns > div > div:nth-child(7) > div:nth-child(6) > footer > div.container); // use here the correct CSS selector for your use case
              if (footer != null) {
                footer.remove(); // remove the HTML element. Instead, to simply hide the HTML element, use footer.style.display = 'none';
              }
            """, injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START)
          ]),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
              useOnLoadResource: true,
              javaScriptEnabled: true,
              supportZoom: false, // Disable zoom controls
            ),
          ),
        ),
      );
    }
  }*/


  import 'dart:async';
  import 'dart:io';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/services.dart';
  import 'package:internet_popup/internet_popup.dart';
import 'package:webview_flutter/webview_flutter.dart';

  class AboutUsPage extends StatefulWidget {
    final String url;
    const AboutUsPage({Key? key, required this.url}) : super(key: key);

    @override
    State<AboutUsPage> createState() => _AboutUsState();
  }

  class _AboutUsState extends State<AboutUsPage> {
    final GlobalKey webViewKey = GlobalKey();
    late WebViewController webViewController;
    bool isLoading = true;

    @override
    void initState() {
      super.initState();
      InternetPopup().initialize(context: context);
    }

    num position = 1;

    final key = UniqueKey();

    doneLoading(String A) {
      setState(() {
        position = 0;
      });
    }

    startLoading(String A) {
      setState(() {
        position = 1;
      });
    }

    @override
    Widget build(BuildContext context) {
      return WillPopScope(
          onWillPop: _onBackPressed,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Home"),
              backgroundColor: Colors.indigo,
            ),
            body: Stack(children: <Widget>[
              WebView(
                zoomEnabled: false,
                initialUrl: "https://www.tutorialspoint.com/about/about_privacy.htm",
                javascriptMode: JavascriptMode.unrestricted,
                allowsInlineMediaPlayback: true,
                debuggingEnabled: true,
                userAgent: "",
                onWebViewCreated: (controller) {
                  setState(() {
                    this.webViewController = controller;

                    webViewController.evaluateJavascript("javascript:(function() { " +
                        "var header = document.getElementsByTagName('header')[0];" +
                        "header.parentNode.removeChild(header);" +
                        "})()");
                    webViewController.evaluateJavascript("javascript:(function() { " +
                        "var footer = document.getElementsByTagName('footer')[0];" +
                        "footer.parentNode.removeChild(footer);" +
                        "})()");
                  });
                },
                onProgress: (int progress) {
                  webViewController.evaluateJavascript("javascript:(function() { " +
                      "var header = document.getElementsByTagName('header')[0];" +
                      "header.parentNode.removeChild(header);" +
                      "})()");
                  webViewController.evaluateJavascript("javascript:(function() { " +
                      "var footer = document.getElementsByTagName('footer')[0];" +
                      "footer.parentNode.removeChild(footer);" +
                      "})()");
                },
                onPageStarted: (url) {
                  webViewController.evaluateJavascript("javascript:(function() { " +
                      "var header = document.getElementsByTagName('header')[0];" +
                      "header.parentNode.removeChild(header);" +
                      "})()");
                  webViewController.evaluateJavascript("javascript:(function() { " +
                      "var footer = document.getElementsByTagName('footer')[0];" +
                      "footer.parentNode.removeChild(footer);" +
                      "})()");
                },
                onPageFinished: (String url) {
                  setState(() {
                    isLoading = false;
                  });
                  webViewController.evaluateJavascript("javascript:(function() { " +
                      "var header = document.getElementsByTagName('header')[0];" +
                      "header.parentNode.removeChild(header);" +
                      "})()");
                  webViewController.evaluateJavascript("javascript:(function() { " +
                      "var footer = document.getElementsByTagName('footer')[0];" +
                      "footer.parentNode.removeChild(footer);" +
                      "})()");
                },
                gestureNavigationEnabled: true,
              ),
              isLoading
                  ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.green,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.indigo,  //<-- SEE HERE
                  ),
                ),
              )
                  : Stack(),
            ]),
          ));
    }

    Future<bool> _onBackPressed() async {
      return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text("Are you sure want to exit?"),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              SystemNavigator.pop();
                              //exit(0);
                            },
                            child: Text("Yes"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.indigo),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child:
                              Text("No", style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.indigo,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    }
  }




