import 'package:digipark/widgets/skeleton_container.dart';
import 'package:flutter/material.dart';

Widget buildSkeletonMenuUtama(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: SkeletonContainer.rounded(
              width: 1000.0,
            ),
          ),
        ),
        Container(
          height: size.height * 0.10,
          margin: const EdgeInsets.only(top: 33, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: SkeletonContainer.rounded(
                  borderRadius: BorderRadius.circular(14),
                  width: MediaQuery.of(context).size.width * 0.157,
                  height: MediaQuery.of(context).size.width * 0.157,
                ),
              ),
              Spacer(),
              Expanded(
                flex: 5,
                child: SkeletonContainer.rounded(
                  borderRadius: BorderRadius.circular(14),
                  width: MediaQuery.of(context).size.width * 0.157,
                  height: MediaQuery.of(context).size.width * 0.157,
                ),
              ),
              Spacer(),
              Expanded(
                flex: 5,
                child: SkeletonContainer.rounded(
                  borderRadius: BorderRadius.circular(14),
                  width: MediaQuery.of(context).size.width * 0.157,
                  height: MediaQuery.of(context).size.width * 0.157,
                ),
              ),
              Spacer(),
              Expanded(
                flex: 5,
                child: SkeletonContainer.rounded(
                  borderRadius: BorderRadius.circular(14),
                  width: MediaQuery.of(context).size.width * 0.157,
                  height: MediaQuery.of(context).size.width * 0.157,
                ),
              ),
              Spacer(),
              Expanded(
                flex: 5,
                child: SkeletonContainer.rounded(
                  borderRadius: BorderRadius.circular(14),
                  width: MediaQuery.of(context).size.width * 0.157,
                  height: MediaQuery.of(context).size.width * 0.157,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.08),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SkeletonContainer.rounded(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.08),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.152,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.152,
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.015,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 3),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 3),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 66),
            child: SkeletonContainer.rounded(
              borderRadius: BorderRadius.circular(50),
              width: MediaQuery.of(context).size.width * 0.33,
              height: MediaQuery.of(context).size.height * 0.035,
            ),
          ),
        ),
        //pemisah
        SizedBox(height: MediaQuery.of(context).size.width * 0.1),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SkeletonContainer.rounded(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.08),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.152,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.152,
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.015,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 3),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 3),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 66),
            child: SkeletonContainer.rounded(
              borderRadius: BorderRadius.circular(50),
              width: MediaQuery.of(context).size.width * 0.33,
              height: MediaQuery.of(context).size.height * 0.035,
            ),
          ),
        ),
        //pemisah
        SizedBox(height: MediaQuery.of(context).size.width * 0.1),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SkeletonContainer.rounded(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.08),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.152,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.152,
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.015,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 3),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 3),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 66),
            child: SkeletonContainer.rounded(
              borderRadius: BorderRadius.circular(50),
              width: MediaQuery.of(context).size.width * 0.33,
              height: MediaQuery.of(context).size.height * 0.035,
            ),
          ),
        ),
        //pemisah
        SizedBox(height: MediaQuery.of(context).size.width * 0.1),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SkeletonContainer.rounded(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.08),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.152,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.152,
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.015,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 3),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 3),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 66),
            child: SkeletonContainer.rounded(
              borderRadius: BorderRadius.circular(50),
              width: MediaQuery.of(context).size.width * 0.33,
              height: MediaQuery.of(context).size.height * 0.035,
            ),
          ),
        ),
        //pemisah
        SizedBox(height: MediaQuery.of(context).size.width * 0.1),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SkeletonContainer.rounded(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.08),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.152,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.152,
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.015,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 3),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 3),
          child: Row(
            children: [
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.585,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SkeletonContainer.rounded(
                borderRadius: BorderRadius.circular(14),
                width: MediaQuery.of(context).size.width * 0.275,
                height: MediaQuery.of(context).size.height * 0.013,
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 66),
            child: SkeletonContainer.rounded(
              borderRadius: BorderRadius.circular(50),
              width: MediaQuery.of(context).size.width * 0.33,
              height: MediaQuery.of(context).size.height * 0.035,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSkeletonDrawer(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SkeletonContainer.circular(
            width: MediaQuery.of(context).size.width * 0.26,
            height: MediaQuery.of(context).size.width * 0.26,
          ),
        ],
      ),
    ],
  );
}

Widget buildSkeletonSidebarProfilSaya(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: SkeletonContainer.circular(
            width: size.height * 0.158,
            height: size.height * 0.158,
          ),
        ),
        SizedBox(
          height: size.height * 0.025,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(50),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        SizedBox(
          height: size.height * 0.005,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(50),
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        SizedBox(
          height: size.height * 0.035,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(15),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        SizedBox(
          height: size.height * 0.035,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(15),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        SizedBox(
          height: size.height * 0.035,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(15),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        SizedBox(
          height: size.height * 0.048,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(50),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.06,
        ),
      ],
    ),
  );
}

Widget buildSkeletonDeskripsi(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(50),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(15),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        SizedBox(
          height: size.height * 0.035,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(15),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.13,
        ),
        SizedBox(
          height: size.height * 0.035,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(15),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        SizedBox(
          height: size.height * 0.035,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(15),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.19,
        ),
        SizedBox(
          height: size.height * 0.07,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(15),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        SizedBox(
          height: size.height * 0.035,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(15),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        SizedBox(
          height: size.height * 0.035,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(15),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        SizedBox(
          height: size.height * 0.048,
        ),
        SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(50),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.06,
        ),
      ],
    ),
  );
}

Widget buildSkeletonSlide(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: <Widget>[
      AspectRatio(
        aspectRatio: 16 / 9,
        child: SkeletonContainer.rounded(
          width: 1000.0,
        ),
      ),
    ],
  );
}

Widget buildSkeletonList(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: <Widget>[
      AspectRatio(
        aspectRatio: 16 / 9,
        child: SkeletonContainer.rounded(
          width: size.width * 8,
        ),
      ),
    ],
  );
}

Widget buildSkeletonLogoMendaftar(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Center(
    child: AspectRatio(
      aspectRatio: size.height * 0.65 / size.height * 1.8,
      child: SkeletonContainer.rounded(
        width: size.width * 8,
      ),
    ),
  );
}

Widget buildSkeletonListView(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: <Widget>[
      AspectRatio(
        aspectRatio: size.height * 0.65 / size.height * 2.35,
        child: SkeletonContainer.rounded(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ],
  );
}

Widget buildSkeletonPhotoReview(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Container(
    height: 35.0,
    width: 35.0,
    child: SkeletonContainer.rounded(
      borderRadius: BorderRadius.circular(25),
    ),
  );
}
Widget buildSkeletonQRCode(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Container(
    height: size.height * 0.45,
    width: size.width * 1, child: SkeletonContainer.rounded(
      borderRadius: BorderRadius.circular(1),
    ),
  );
}
Widget buildSkeletonImageReview(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.333,
    height: size.height * 0.105,
    child: SkeletonContainer.rounded(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

Widget buildSkeletonMenu(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(4, 5, 4, 10),
          child: AspectRatio(
            aspectRatio: size.height * 0.87 / size.height * 4,
            child: Container(
              child: Row(
                children: [
                  Row(
                    children: [
                      AspectRatio(
                        aspectRatio: size.height * 0.65 / size.height * 2.35,
                        child: SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.025,
                  ),
                  AspectRatio(
                    aspectRatio: size.height * 0.65 / size.height * 2.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.053,
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(4, 5, 4, 10),
          child: AspectRatio(
            aspectRatio: size.height * 0.87 / size.height * 4,
            child: Container(
              child: Row(
                children: [
                  Row(
                    children: [
                      AspectRatio(
                        aspectRatio: size.height * 0.65 / size.height * 2.35,
                        child: SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.025,
                  ),
                  AspectRatio(
                    aspectRatio: size.height * 0.65 / size.height * 2.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.053,
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(4, 5, 4, 10),
          child: AspectRatio(
            aspectRatio: size.height * 0.87 / size.height * 4,
            child: Container(
              child: Row(
                children: [
                  Row(
                    children: [
                      AspectRatio(
                        aspectRatio: size.height * 0.65 / size.height * 2.35,
                        child: SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.025,
                  ),
                  AspectRatio(
                    aspectRatio: size.height * 0.65 / size.height * 2.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.053,
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(4, 5, 4, 10),
          child: AspectRatio(
            aspectRatio: size.height * 0.87 / size.height * 4,
            child: Container(
              child: Row(
                children: [
                  Row(
                    children: [
                      AspectRatio(
                        aspectRatio: size.height * 0.65 / size.height * 2.35,
                        child: SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.025,
                  ),
                  AspectRatio(
                    aspectRatio: size.height * 0.65 / size.height * 2.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.053,
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(4, 5, 4, 10),
          child: AspectRatio(
            aspectRatio: size.height * 0.87 / size.height * 4,
            child: Container(
              child: Row(
                children: [
                  Row(
                    children: [
                      AspectRatio(
                        aspectRatio: size.height * 0.65 / size.height * 2.35,
                        child: SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.025,
                  ),
                  AspectRatio(
                    aspectRatio: size.height * 0.65 / size.height * 2.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.053,
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        SkeletonContainer.rounded(
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * 0.700,
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSkeletonBankRekening(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(4, 5, 4, 10),
          child: AspectRatio(
            aspectRatio: size.height * 0.79 / size.height * 4,
            child: SkeletonContainer.rounded(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(4, 5, 4, 10),
          child: AspectRatio(
            aspectRatio: size.height * 0.79 / size.height * 4,
            child: SkeletonContainer.rounded(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(4, 5, 4, 10),
          child: AspectRatio(
            aspectRatio: size.height * 0.79 / size.height * 4,
            child: SkeletonContainer.rounded(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(4, 5, 4, 10),
          child: AspectRatio(
            aspectRatio: size.height * 0.79 / size.height * 4,
            child: SkeletonContainer.rounded(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(4, 5, 4, 10),
          child: AspectRatio(
            aspectRatio: size.height * 0.79 / size.height * 4,
            child: SkeletonContainer.rounded(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSkeletonDetail(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: SkeletonContainer.rounded(
              width: 1000.0,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.12),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SkeletonContainer.rounded(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.04),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SkeletonContainer.rounded(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.13),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
      ],
    ),
  );
}

Widget buildSkeletonDetailBank(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.width * 0.12),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SkeletonContainer.rounded(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.04),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SkeletonContainer.rounded(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.13),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
          child: SkeletonContainer.rounded(
            borderRadius: BorderRadius.circular(14),
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
      ],
    ),
  );
}
