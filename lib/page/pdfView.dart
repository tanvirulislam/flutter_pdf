import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:test_project/utilities/utilities.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  PrintingInfo? printingInfno;

  Future<void> _int() async {
    final info = await Printing.info();
    setState(() {
      printingInfno = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _int();
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(
          icon: Icon(Icons.save),
          onPressed: saveFile,
        )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdf View'),
      ),
      body: PdfPreview(
        build: generatedPdf,
        actions: actions,
        maxPageWidth: 700,
        onPrinted: (context) => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Print Successfull'))),
        onShared: (context) => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('share Successfull'))),
      ),
    );
  }
}
