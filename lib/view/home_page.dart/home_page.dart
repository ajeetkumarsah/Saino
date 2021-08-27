import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saino/db/firebase_provider.dart';
import 'package:saino/model/form_data.dart';
import 'package:saino/view/other_page/form_data.dart';
import 'package:saino/widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainContainer();
  }
}

class MainContainer extends StatefulWidget {
  const MainContainer({Key? key}) : super(key: key);

  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  List<OurFormDataModel> allData = [];
  get getAllData => this.allData;

  set setAllData(allData) => this.allData = allData;
  Stream<QuerySnapshot> getFormData() => firebaseProvider.getMyData();

  List<OurFormDataModel> mapToList(QuerySnapshot snapshot) {
    List<OurFormDataModel> data = [];
    snapshot.docs.forEach((element) {
      OurFormDataModel trip = OurFormDataModel.fromSnapToModel(
          element.data() as Map<String, dynamic>);

      data.add(trip);
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Saino',
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: getFormData(),
            builder: (context, stream) {
              if (stream.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }

              if (stream.hasError) {
                return Center(child: Text(stream.error.toString()));
              }
              allData = mapToList(stream.data as QuerySnapshot);
              return ListView.builder(
                itemCount: allData.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final OurFormDataModel data = allData[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/user.png'),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(data.fName!),
                          SizedBox(width: 10),
                          Text(data.lName!),
                        ],
                      ),
                      subtitle: Text(data.gender!),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data.country!),
                          SizedBox(height: 10),
                          Text('${data.number}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, FormData.routeName),
          child: Center(
            child: Icon(Icons.arrow_forward_ios),
          ),
        ));
  }
}
