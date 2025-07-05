import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HtmlDisplayScreen extends StatefulWidget {
  final String decodedDescription;

  const HtmlDisplayScreen({Key? key, required this.decodedDescription}) : super(key: key);

  @override
  State<HtmlDisplayScreen> createState() => _HtmlDisplayScreenState();
}

class _HtmlDisplayScreenState extends State<HtmlDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTML Content')),
      body: HtmlWidget(
        widget.decodedDescription,
        // Remove all padding
        renderMode: RenderMode.column,
        enableCaching: true,
        textStyle: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black),

        // Fix full width image styles
        customStylesBuilder: (element) {
          if (element.localName == 'img' || element.localName == 'figure' || element.localName == 'p') {
            return {
              'margin': '0',
              'padding': '0',
              'width': '100%',
              'display': 'block',
            };
          }
          return null;
        },

        // Force images to take full width
        customWidgetBuilder: (element) {
          if (element.localName == 'img') {
            final src = element.attributes['src'];
            if (src != null && src.isNotEmpty) {
              return Image.network(
                src,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              );
            }
          }
          return null;
        },
      ),
    );
  }
}
