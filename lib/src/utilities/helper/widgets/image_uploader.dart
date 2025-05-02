import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dv_pay_mobile/src/utilities/general.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader extends StatefulWidget {
  final Function(File? image)? onImageSelected;
  final Function(double progress)? onUploadProgress;
  final Function(String path, String imagUrl)? onUploadSuccess;
  final Function(String error)? onUploadError;
  final Widget child;
  final bool showPreview;

  const ImageUploader({
    super.key,
    required this.child,
    this.onImageSelected,
    this.onUploadProgress,
    this.onUploadSuccess,
    this.onUploadError,

    this.showPreview = true,
  });

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _image;
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String? _uploadedUrl;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _cropImage(File(pickedFile.path));
    }
  }

  Future<void> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ],
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ],
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _image = File(croppedFile.path);
      });
      if (widget.onImageSelected != null) {
        widget.onImageSelected!(_image);
      }
      // Call upload image after picking and cropping
      _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    try {
      // Create FormData
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          _image!.path,
          filename: _image!.path.split('/').last,
          contentType: MediaType('image', 'jpeg'),
        ),
      });

      // Initialize Dio
      Dio dio = Dio();

      // Add logging interceptor to debug the API calls
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

      // Upload the file
      var response = await dio.post(
        '${app.env.baseUrl + app.env.apiPath}/uploadImg/uploadImg',
        options: Options(headers: {'Authorization': app.token, 'Content-Type': 'multipart/form-data'}),
        data: formData,
        onSendProgress: (int sent, int total) {
          final progress = sent / total;
          setState(() {
            _uploadProgress = progress;
          });

          if (widget.onUploadProgress != null) {
            widget.onUploadProgress!(progress);
          }
        },
      );

      if (response.statusCode == 200) {
        // Check the actual structure of response data
        if (response.data is Map<String, dynamic>) {
          // Try different paths to find the URL based on response structure
          final responseData = response.data as Map<String, dynamic>;

          // First try the expected path
          String? path = responseData['data']['path'];
          String? url = responseData['data']['url'];

          if (url != null && url.isNotEmpty) {
            _uploadedUrl = url;

            if (widget.onUploadSuccess != null) {
              widget.onUploadSuccess!(path!, _uploadedUrl!);
            }

            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Image uploaded successfully!')));
          } else {
            if (widget.onUploadError != null) {
              widget.onUploadError!('URL not found in response');
            }

            if (!mounted) return;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Failed to retrieve image URL from response')));
          }
        } else {
          if (widget.onUploadError != null) {
            widget.onUploadError!('Unexpected response format');
          }

          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unexpected response format')));
        }
      } else {
        if (widget.onUploadError != null) {
          widget.onUploadError!('Failed to upload image');
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to upload image.')));
      }
    } catch (e) {
      if (widget.onUploadError != null) {
        widget.onUploadError!(e.toString());
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: _pickImage, child: widget.child);
  }
}
