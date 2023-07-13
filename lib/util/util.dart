import 'dart:developer';
import 'dart:io';
// import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generatedPdf(PdfPageFormat pageFormat) async {
  final font = await rootBundle.load('assets/OpenSansRegular.ttf');
  final doc = pw.Document();
  final ttf = pw.Font.ttf(font);
  doc.addPage(pw.MultiPage(
    build: (context) {
      return [
        pw.Container(
          child: pw.Column(children: [
            pw.Text(
              'Flutter Pdf',
              style: pw.TextStyle(font: ttf),
            ),
          ]),
        ),
      ];
    },
  ));
  return doc.save();
}

Future saveFile(
  final BuildContext context,
  final LayoutCallback build,
  final PdfPageFormat pageFormat,
) async {
  final bytes = await build(pageFormat);

  final dir = await getApplicationDocumentsDirectory();
  final dirPath = dir.path;
  final file = File("$dirPath/document.pdf");
  log(file.path.toString());
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}
