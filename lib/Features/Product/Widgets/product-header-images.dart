import 'package:flutter/material.dart';

class ProductHeaderImagesBox extends StatelessWidget {
  const ProductHeaderImagesBox({
    Key? key,
    required this.thumbnail,
    required this.images,
  }) : super(key: key);
  final String thumbnail;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, cons) {
        final headerImageCons = cons.maxWidth * 7 / 10;
        final littleImageCons = headerImageCons / 3 - 5;
        // final horizentalPadding = cons.maxWidth / 25;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: headerImageCons,
              height: headerImageCons,

              // constraints: BoxConstraints(
              //   maxWidwth: headerImageCons,
              //   maxHeight: headerImageCons,
              // ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  thumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, obj, _) => Image.asset(
                    'assets/Images/program_placeholder.png',
                    width: cons.maxWidth * 28 / 10,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(width: 7.5),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, ind) => ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: littleImageCons,
                    maxHeight: littleImageCons,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      images[ind],
                      fit: BoxFit.fitHeight,
                      height: littleImageCons,
                      errorBuilder: (ctx, obj, _) => Image.asset(
                        'assets/Images/program_placeholder.png',
                        // width: cons.maxWidth * 28 / 10,
                        height: 200,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (ctx, ind) => SizedBox(height: 7.5),
                itemCount: images.length > 3 ? 3 : images.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
