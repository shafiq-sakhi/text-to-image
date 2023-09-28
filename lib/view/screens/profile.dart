import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_to_image/controller/admin_base_controller.dart';
import 'package:text_to_image/utils/app_cache_image.dart';
import 'package:text_to_image/utils/app_language.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _name = '';
  final User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final _uid = user.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    print("…..user id ${user.email}...");
    setState(() {
      _name = user.email!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLanguage.PROFILE),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: double.infinity),
                Center(
                  child: AppCacheImage(
                      imageUrl:
                          AdminBaseController.userData.value.photoUrl ?? "",
                      width: 120,
                      round: 60,
                      height: 120),
                ),
                SizedBox(height: 20),
                Text(AppLanguage.NAME),
                Text(AdminBaseController.userData.value.name ?? "",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text(AppLanguage.EMAIL),
                Text(AdminBaseController.userData.value.email ?? "",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text(AppLanguage.PHONE_NUMBER),
                Text(AdminBaseController.userData.value.phone ?? "",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _name = '';
  final User user = FirebaseAuth.instance.currentUser!;
  //final user = FirebaseAuth.instance.currentUser!;
  void getData() async {

    final _uid = user.uid;
    print('user.displayName ${user.photoURL}');
    final DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _name = userDoc.get("Name");
      print('this the name: $_name');
      //_phoneNo = userDoc.get("")
    });
  }
// @override
//   void initState() {
//     // TODO: implement initState
//   getData();
//     super.initState();
//   }
  //
  //   setstate(0) {
  // _name = userDoc. get ('name');
  // _email = user.email;
  // _joinedAt = userDoc. get ('joinedAt");
  //     _phoneNumber = userDoc. get ('phoneNumber');
  // userImageUr] =userDoc. get ('imageUr]');
  //

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //appBar: AppBar(),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          NetworkImage(user.photoURL!),
                    ),
                    SizedBox(width: 8),
                    Text('$_name',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Text('what do you want to do today?',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
/*class Profile extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late File _image;
  late String _imageUrl;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<String> uploadImage() async {
    final StorageReference storageReference = FirebaseStorage().ref().child('images/${Path.basename(_image.path)}');
    final StorageUploadTask uploadTask = storageReference.putFile(_image);
    final StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;
    return storageSnapshot.ref.getDownloadURL();
  }

  void saveData() async {
    String imageUrl = await uploadImage();
    setState(() {
      _imageUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image, height: 150),
            _imageUrl == null
                ? Container()
                : Image.network(_imageUrl, height: 150),
            RaisedButton(
              child: Text('Select Image'),
              onPressed: getImage,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: saveData,
            ),
          ],
        ),
      ),
    );
  }
}*/
