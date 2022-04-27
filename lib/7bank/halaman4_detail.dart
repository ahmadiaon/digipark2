import 'dart:isolate';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digipark/0lainlain/modal.dart';
import 'package:digipark/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:digipark/customdialog/CustomDialog.dart';

class DetailPinjamDana extends StatefulWidget {
  final ListSubmissionBank list_submission;
  DetailPinjamDana(this.list_submission);

  @override
  _DetailPinjamDanaState createState() => _DetailPinjamDanaState();
}

class _DetailPinjamDanaState extends State<DetailPinjamDana> {
  Future download(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();

      await FlutterDownloader.enqueue(
        url: url,
        saveInPublicStorage: true,
        savedDir: baseStorage.path,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    }
  }

  showAlertDialogTerdaftar() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              judul: "File Sudah Terdownload",
              deskripsi: "File yg didownload sudah ada pada file manager",
              gambar: Image.asset("assets/icons/failed.png"),
            ));
  }

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.failed) {
        showAlertDialogTerdaftar();
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.052),
        child: AppBar(
          elevation: 0,
          foregroundColor: Colors.black87,
          centerTitle: true,
          backgroundColor: Color(0xFFFFC600),
          title: Text(
            "Detail Peminjaman Dana",
            style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: size.height * 0.05,
        child: FloatingActionButton.extended(
          // splashColor: Colors.green,
          onPressed: () async {
            download(URL_FULL +
                widget.list_submission.pdf);
          },
          label: Text(
            'Unduh Data',
            style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          icon: Icon(
            LineIcons.fileDownload,
            color: Colors.black87,
          ),
          backgroundColor: Color(0xFFFFC600),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.grey[200],
            ),
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            height: size.height * 0.26,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: CachedNetworkImage(
                imageUrl: URL_FULL +
                    widget.list_submission.identity_card,
                //                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                // CircularProgressIndicator(value: downloadProgress.progress),
                // placeholder: (context,
                //         url) =>
                //     CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Container(
            // margin: EdgeInsets.only(top: size.height * 0.3),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                )),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SelectableText(
                    widget.list_submission.name,
                    style: GoogleFonts.inter(
                        fontSize: 18, height: 1.5, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    width: size.width * 0.38,
                    height: size.height * 0.005,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFC600),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    height: size.height * 0.017,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SelectableText(
                        widget.list_submission.address,
                        style: GoogleFonts.inter(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SelectableText(
                    'Nama usaha : ' + widget.list_submission.business_name,
                    style: GoogleFonts.inter(
                        fontSize: 18, height: 1.5, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SelectableText(
                        widget.list_submission.business_address,
                        style: GoogleFonts.inter(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SelectableText(
                    'Pendapatan per bulan : ' + widget.list_submission.income,
                    style: GoogleFonts.inter(
                        fontSize: 16, height: 1.5, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SelectableText(
                    'Pinjaman untuk : ' + widget.list_submission.purpose,
                    style: GoogleFonts.inter(
                        fontSize: 18, height: 1.5, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SelectableText(
                    'Estimasi pinjaman : ' +
                        widget.list_submission.loan_estimate,
                    style: GoogleFonts.inter(
                        fontSize: 16, height: 1.5, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
