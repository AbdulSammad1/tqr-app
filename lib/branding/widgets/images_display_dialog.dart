import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagesDisplayDialog extends StatefulWidget {
  List<String> images;
  bool isFront;
  ImagesDisplayDialog({super.key, required this.images, required this.isFront});

  @override
  State<ImagesDisplayDialog> createState() => _ImagesDisplayDialogState();
}

class _ImagesDisplayDialogState extends State<ImagesDisplayDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text(widget.isFront ? 'Front Images' : 'Back Images'), backgroundColor: Colors.transparent,),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1.2),
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                var item = widget.images[index];
                return Stack(
                  children: [
                    SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Image.asset(item, fit: BoxFit.cover,),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
