import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';




class TakePhotoPage extends StatefulWidget {
  final CameraDescription camera;

  const TakePhotoPage({required this.camera});

  @override
  _TakePhotoPageState createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Photo'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            Navigator.pop(context, File(image.path));
          } catch (e) {
            print(e);
          }
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final String username;

  ProfilePage({required this.username});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  var name = '';
  var email = '';
  var phone = '';
  late File profilePictureFile = File('');

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Future<void> _takePhoto() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePhotoPage(camera: firstCamera),
      ),
    );

    setState(() {
      if (result != null) {
        _image = File(result.path);
      } else {
        print('No image captured.');
      }
    });
  }

  Future<void> fetchData() async {
    var url = Uri.parse("http://192.168.0.166/database/getdata.php");
    var response = await http.post(url, body: {
      "username": widget.username,
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      if (jsonData == "failed") {
        print('Username not found in the database');
      } else {
        setState(() {
          name = jsonData['firstname'];
          email = widget.username;
          phone = jsonData['mobile'];
        });

        saveDataToSharedPreferences(name, email, phone);
      }
    } else {
      print('Failed to fetch data');
    }
  }

  void saveDataToSharedPreferences(String name, String email, String phone) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('name', name);
    sharedPref.setString('email', email);
    sharedPref.setString('phone', phone);
  }
  void selectProfilePicture() async {
    final picker = ImagePicker();
    final pickedImage = await showModalBottomSheet<PickedFile?>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a photo'),
                onTap: () => _takePhoto(),
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    if (pickedImage != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          profilePictureFile = File(pickedImage.path);
        });
      });
    }
  }


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Your Profile'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: selectProfilePicture,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: _image != null ? FileImage(_image!) : null,
              ),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(widget.username),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(phone),
            ),
          ],
        ),
      ),
    );
  }
}