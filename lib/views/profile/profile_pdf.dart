import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ProfilePdf extends StatefulWidget {
  final String title;
  final String path;
  const ProfilePdf({super.key, required this.title, required this.path});

  @override
  State<ProfilePdf> createState() => _ProfilePdfState();
}

class _ProfilePdfState extends State<ProfilePdf> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.asset(
        widget.path,
        key: _pdfViewerKey,
      ),
    );
  }
}
