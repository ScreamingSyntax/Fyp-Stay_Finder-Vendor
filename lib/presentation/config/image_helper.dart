import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

class ImageHelper {
  final ImagePicker imagePicker;
  final ImageCropper imageCropper;
  ImageHelper({ImagePicker? imagePicker, ImageCropper? imageCropper})
      : imagePicker = imagePicker ?? ImagePicker(),
        imageCropper = imageCropper ?? ImageCropper();
  Future<List<XFile>> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 100,
    bool multiple = false,
  }) async {
    if (multiple) {
      return await imagePicker.pickMultiImage(imageQuality: imageQuality);
    }
    final file =
        await imagePicker.pickImage(source: source, imageQuality: imageQuality);
    if (file != null) return [file];
    return [];
  }

  Future<CroppedFile?> crop(
          {required XFile file,
          CropStyle cropStyle = CropStyle.rectangle}) async =>
      await imageCropper.cropImage(
          cropStyle: cropStyle,
          sourcePath: file.path,
          compressQuality: 100,
          uiSettings: [IOSUiSettings(), AndroidUiSettings()]);
}
