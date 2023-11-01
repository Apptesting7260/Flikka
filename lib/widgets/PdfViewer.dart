import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewer extends StatefulWidget {
  final String url ;
  const PDFViewer({super.key, required this.url});

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: PDFView(
          filePath: widget.url,
        ),
      ),
    );
  }
}
