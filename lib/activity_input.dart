import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ToiletEntry {
  TextEditingController timeController = TextEditingController();
  String type = 'Diaper';
  String condition = 'DR';
  
  TextEditingController notesController = TextEditingController();
}

class RestEntry {
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
}

class BottleEntry {
  TextEditingController timeController = TextEditingController();
  TextEditingController mlController = TextEditingController();
  String type = 'Breast';
}

class VitaminEntry {
  TextEditingController timeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
}

class ActivityInputScreen extends StatefulWidget {
  final String childName="ian";
  final List anak;
  
   bool StatusPut=false;
  final String id_pengasuh;

  ActivityInputScreen({required this.anak,required this.id_pengasuh});

  @override
  _ActivityInputScreenState createState() => _ActivityInputScreenState();
}

class _ActivityInputScreenState extends State<ActivityInputScreen> {
  final TextEditingController _namaAnakController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _arrivalController = TextEditingController();
  final TextEditingController _bodyTemperatureController = TextEditingController();
  final TextEditingController _conditionsController = TextEditingController();

  // Meal controllers
  final List<TextEditingController> _mealFoodControllers = List.generate(6, (index) => TextEditingController());
  final List<TextEditingController> _mealCommentControllers = List.generate(6, (index) => TextEditingController());
  final List<String> _mealQuantities = List.generate(6, (index) => 'None');

  List<ToiletEntry> _toiletEntries = [];
  List<RestEntry> _restEntries = [];
  List<BottleEntry> _bottleEntries = [];
  List<VitaminEntry> _vitaminEntries = [];

String quantityFinal="1";
  final TextEditingController _showerMorningController = TextEditingController();
  final TextEditingController _showerEveningController = TextEditingController();

  final Map<String, dynamic> _itemNeeds = {
    'Diapers': {'checked': false, 'quantity': '1', 'visible': false},
    'Hand towel': {'checked': false, 'quantity': '1', 'visible': false},
    'Cream': {'checked': false, 'quantity': '1', 'visible': false},
    'Clothes': {'checked': false, 'quantity': '1', 'visible': false},
    'Towel': {'checked': false, 'quantity': '1', 'visible': false},
    'Soap & Shampoo': {'checked': false, 'quantity': '1', 'visible': false},
    'Milk': {'checked': false, 'quantity': '1', 'visible': false},
    'Tooth Paste': {'checked': false, 'quantity': '1', 'visible': false},
    'Other': {'checked': false, 'quantity': '1', 'visible': false},
  };
  final TextEditingController _otherItemController = TextEditingController();
List<dynamic> anak=[];

late String id_laporan="";
late List<Map<String,dynamic>> itemneed=[];
late List<Map<String,dynamic>> meals=[];
late List<Map<String,dynamic>> toilet=[];
late List<Map<String,dynamic>> rest=[];
late List<Map<String,dynamic>> vitamin=[];
late List<Map<String,dynamic>>bottle=[];
  
int indexItemneed=0;
// Future<void>PutDataAnak(String id_anak)async{
//   try {
    
//     final response = await http.post(Uri.parse('http://10.0.2.2/daycare_api/put_Data_anak.php'),body: {'id_anak':id_anak});
//   if (response.statusCode==200) {
//   setState(() {
//     print("Put ID Anak Berhasil...");
//    anak=jsonDecode(response.body);
//    widget.StatusPut=true;
//   });
   
//   } else {
//     setState(() {
      
//    widget.StatusPut=false;
//     });
//     print("Put Id Anak Gagal");
    
//   }
//   }
//   catch(e){
//     print("Put Id Anak Gagal");

//     print(e);
  
//   }
// }


// TOILET
bool statusPostToilet=false;
Future<void>postToilet(String value,String value2,String value3,String value4)async{
  try{
    
      final response = await http.post(Uri.parse('http://10.0.2.2/daycare_api/post_Data_toilet.php'),body: {
"waktu":value,
"type":value2,
"kondisi":value3,
"catatan":value4,
'id_laporan':id_laporan,
    });
   var $result=jsonDecode(response.body);
  if($result["status"]=="Berhasil"){
    print("Api Toilet Berhasil di gunakan...");
    setState(() {
      statusPostToilet=true;
    });
  }

  }
  catch(e){
    setState(() {
    print("Api Toilet Gagal di gunakan...");
      statusPostToilet=false;
    });
    print(e);
  }
}
    
// MEALLL
bool statusPostMeal=false;
Future<void>postMeal(String value,String value2,String value3)async{
  try{
    
      final response = await http.post(Uri.parse('http://10.0.2.2/daycare_api/post_Data_meals.php'),body: {
"food":value,
"quantity":value2,
"comment":value3,
'id_laporan':id_laporan,
    });
    
   var $result=jsonDecode(response.body);
  if($result["status"]=="Berhasil"){

print("Api Meal Berhasil di gunakan...");
    setState(() {
      statusPostMeal=true;
    });
  }

  }
  catch(e){
    setState(() {
print("Api Meal Gagal di gunakan...");
      statusPostMeal=false;
    });
    print(e);
  }
}

// RESTT
bool statusPostReast=false;
Future<void>postReast(String value,String value2)async{
  try{
    
      final response = await http.post(Uri.parse('http://10.0.2.2/daycare_api/post_Data_rest.php'),body: {
"start_time":value,
"end_time":value2,
'id_laporan':id_laporan,
    });
    
   var $result=jsonDecode(response.body);
  if($result["status"]=="Berhasil"){
    
print("Api Rest Berhasil di gunakan...");
    setState(() {
      statusPostReast=true;
    });
  }

  }
  catch(e){
    setState(() {
      statusPostReast=false;
print("Api Rest Gagal di gunakan...");
    });
    print(e);
  }
}


// Bottle
bool statusPostBottle = false;
Future<void> postBottle(String time, String ML, String type) async {
  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2/daycare_api/post_Data_bottle.php'),
      body: {
        "time": time,
        "ML": ML,
        "type": type,
        'id_laporan':id_laporan,
      },
    );

    var result = jsonDecode(response.body);
    if (result["status"] == "Berhasil") {
      
print("Api Bottle Berhasil di gunakan...");
      setState(() {
        statusPostBottle = true;
      });
    } else {
      print("POST bottle GAGAL: ${result['message']}");
      setState(() {
        statusPostBottle = false;
      });
    }
  } catch (e) {
    print("Error pada saat POST bottle: $e");
    setState(() {
      statusPostBottle = false;
    });
  }
}

bool statusPostShower = false;

Future<void> postShower(String morningShower, String eveningShower) async {
  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2/daycare_api/post_Data_shower.php'),
      body: {
        "morning_shower": morningShower,
        "evening_shower": eveningShower,
        'id_laporan':id_laporan,
      },
    );

    var result = jsonDecode(response.body);
    if (result["status"] == "Berhasil") {
      
print("Api Shower Berhasil di gunakan...");
      statusPostShower = true;
    } else {
      print("Api shower GAGAL: ${result['message']}");
      statusPostShower = false;
    }
  } catch (e) {
    print("Error pada saat API POST shower: $e");
    statusPostShower = false;
  }
}


bool statusPostVitamin = false;

  //------------------------------ POST TO Vitamin------------------------------
Future<void> postVitamin(String vitaminName, String amount, String time) async {
  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2/daycare_api/post_Data_vitamin.php'),
      body: {
        "vitamin_name": vitaminName,
        "amount": amount,
        "time": time,
        'id_laporan':id_laporan,
      },
    );

    var result = jsonDecode(response.body);
    if (result["status"] == "Berhasil") {
print("Api Vitamin Berhasil di gunakan...");
      statusPostVitamin = true;
    } else {
      print("POST vitamin GAGAL: ${result['message']}");
      statusPostVitamin = false;
    }
  } catch (e) {
    print("Error pada saat POST vitamin: $e");
    statusPostVitamin = false;
  }
}
  
  //------------------------------ POST TO Item------------------------------

bool statusPostItem = false;

Future<void> postItem(String key, String quantity) async {
  if (quantity=='none'||quantity=='None') {
    quantity='1';
  }
  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2/daycare_api/post_Data_item.php'),
      body: {
        "key": key,
        "quantity": quantity,
        'id_laporan':id_laporan,
      },
    );
    
    var result = jsonDecode(response.body);
    if (result["status"] == "Berhasil") {
print("Api Item Berhasil di gunakan...");
      statusPostItem = true;
    } else {
      print("POST item GAGAL: ${result['message']}");
      statusPostItem = false;
    }
  } catch (e) {
    print("Error pada saat POST item: $e");
    statusPostItem = false;
  }
}

Future<bool> laporanAnak(String $id_anak)async {
  if ($id_anak!='') {
    if (widget.anak[0]['id']!=" ") {
try {
if (_arrivalController.text==''||_bodyTemperatureController.text==''||_conditionsController.text=='') {
 
  return false;
}
else{
   print(_bodyTemperatureController.text);
  print(_conditionsController.text);
  print(_arrivalController.text);
  var response= await http.post(Uri.parse('http://10.0.2.2/daycare_api/post_Data_laporananak.php'),body: {
    'id_anak':widget.anak[0]['id'],
    'arrival_time':_arrivalController.text,
    'temperature':_bodyTemperatureController.text,
    'kondisi':_conditionsController.text,
    
  });
    if (response.statusCode==200 || response.statusCode==201 ) {

    
    var result=jsonDecode(response.body);
    if (result['status']!="Gagal") {
      if (result['new_id']!=" ") {
print("Api Laporan Anak Berhasil di gunakan...");
        setState(() {
          
        id_laporan=result['new_id'].toString();
        });
        return true;
      }else{
setState(() {
  
print("Api Laporan Anak Gagal di gunakan...");
        id_laporan="reset";
});
        
        return false;
      }
    }else{
      // print(result);
      return false;
    }
    print("AMBIL ID NYA LALU TARO DI TABEL LAIN");
    
  }
  else{
    return false;
  }
}


} catch (e) {
  print(e);
}
    return true;
    }else{
      return false;
    }

  }else{return false;}
}


Future<void> updateDataAnak() async{
 bool initialpost= await laporanAnak(widget.anak[0]['id']); 

if (initialpost==true && id_laporan!="reset") {
  print("ID LAPORAN : ${id_laporan}");
  bool initialpost2=false;
  try {

    print("---------------------------------------INFO STATUS----------------------------------------------");
    print("laporan anak selesai, dan selanjutnya post tabel lainnya dengan laporan anak menjadi foreign key");
    print("------------------------------------------------------------------------------------------------");
if (initialpost2==false && widget.anak.length>0) {

  
  //------------------------------ POST TO MEALS------------------------------
  if (meals.length>0) {
   for (var i = 0; i < meals.length; i++) {
     postMeal(meals[i]['Food'], meals[i]['Quantity'], meals[i]['Comment']);
   if (statusPostMeal) {
    print('POST MEAL SUCCES....'); 
   }
   else{
    print("POST MEAL GAGAL");
   }
   }
  }
  //------------------------------ POST TO TOILET------------------------------
   if (toilet.length>0) {

   for (var i = 0; i < toilet.length; i++) {
    postToilet(toilet[i]['waktu'], toilet[i]['type'], toilet[i]['kondisi'], toilet[i]['notes']);
   if (statusPostToilet) {
    print('POST Toilet SUCCES....'); 
   }
   else{
    print("Post TOILET GAGAL");
   }
   }
  }

  //------------------------------ POST TO Rest------------------------------
   if (rest.length>0) {
   for (var i = 0; i < rest.length; i++) {
    
  postReast(rest[i]['start_time'], rest[i]['end_time']);
   if (statusPostReast) {
    print('POST Rest SUCCES....'); 
   }
   else{
    print("POST REST GAGAL");
   }
   }
  }

   //------------------------------ POST TO Bottle------------------------------
   if (bottle.length>0) {
   for (var i = 0; i < bottle.length; i++) {
    
  postBottle(bottle[i]['time'], bottle[i]['ML'],bottle[i]['type']);
   if (statusPostBottle) {
    print('POST bottle SUCCES....'); 
   }
   else{
    print("POST bottle GAGAL");
   }
   }
  }

  //------------------------------ POST TO Showeer------------------------------
  
   if (_showerMorningController.text!="" && _showerEveningController.text!="") {
    
    postShower(_showerEveningController.text, _showerEveningController.text);
   if (statusPostShower) {
    print('POST shower SUCCES....'); 
   }
   else{
    print("POST shower GAGAL");
   }
   }


  //------------------------------ POST TO vitamin------------------------------
 if (vitamin.length>0) {
   for (var i = 0; i < vitamin.length; i++) {
    
     postVitamin(vitamin[i]['vitamin_name'], vitamin[i]['amount'], vitamin[i]['time']);
   if (statusPostVitamin) {
    print('POST Vitamin SUCCES....'); 
   }
   else{
    print("POST Vitamin GAGAL");
   }
   }
  }
  //------------------------------ POST TO Item------------------------------
 if (itemneed.length>0) {
   for (var i = 0; i < itemneed.length; i++) {
     postItem(itemneed[i]['key'], itemneed[i]['quantity']);
   if (statusPostItem) {
    print('POST Item SUCCES....'); 
   }
   else{
    print("GAGAL");
   }
   }
  }




initialpost2=true;
  
} 
}
catch (e) {
  print(e);
  print("UPDATE INITIAL POST BERMASALAH...");
  initialpost2=false;
}
 
 if (initialpost2==true) {
    print("---------------------------------------INFO STATUS----------------------------------------------");
    print("-------------------UPDATE POST BERHASIL TANPA KENDALA, TERIMA KASIH----------------------------- ");
    print("------------------------------------------------------------------------------------------------");

  
  }
 else{
    print("---------------------------------------WARNING INFO----------------------------------------------");
    print("-------------------UPATE POST MENGALMI KENDALA,DAN GAGAL DI EKSEKUSI-----------------------------");
    print("-------------------------------------------------------------------------------------------------");

 }
  
}
else{
    print("---------------------------------------INFO STATUS----------------------------------------------");
    print("-------------------UPATE POST MEMBUTUHKAN BEBERAPA ATTRIBUT, ULANGI----------------------------- ");
    print("------------------------------------------------------------------------------------------------");


}

 }


  @override
  void initState() {
    super.initState();
    //  PutDataAnak(widget.anak[0]['id']);
    // print(widget.result)
    // print(anak[0]['nama_lengkap']);
    _namaAnakController.text =widget.anak[0]['nama_lengkap']; // Mengisi nama anak dari parameter
  }

  void _submitActivity(BuildContext context) {
    // Logic to save child activity data
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Child activity data saved successfully')),
    );
  }

  void _addNewToiletEntry() {
    setState(() {
      _toiletEntries.add(ToiletEntry());
    });
  }

  void _addNewRestEntry() {
    setState(() {
      _restEntries.add(RestEntry());
    });
  }

  void _addNewBottleEntry() {
    setState(() {
      _bottleEntries.add(BottleEntry());
    });
  }

  void _addNewVitaminEntry() {
    setState(() {
      _vitaminEntries.add(VitaminEntry());
    });
  }

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.orange,
            colorScheme: ColorScheme.light(primary: Colors.orange, secondary: Colors.orange),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _tanggalController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void _selectTime(TextEditingController controller,int index,String Object,String label) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.orange,
            colorScheme: ColorScheme.light(primary: Colors.orange, secondary: Colors.orange),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context);
       if (Object=="Toilet") {
      

Map<String,dynamic> toiletNew={
'key':index,
'waktu':"none",
'type':"none",
'kondisi':'none',
'notes':controller.text,
};
if (toilet.length<=0) {
  toilet.add(toiletNew);
}
bool isFind=false;
for (var i = 0; i < toilet.length; i++) {
  if (toilet[i]['key']==index) {
    setState(() {
      
    isFind=true;
    });
    toilet[i]['waktu']=controller.text;
    break;
    
  } 
}
if (isFind) {
}else{
  toilet.add(toiletNew);
}
       }
       
      //  ------------------------------REST OBJECT----------------------
       else if(Object=='Rest'){



Map<String,dynamic> restNew={
'key':index,
'start_time':"none",
'end_time':"none",
};
if (rest.length<=0) {
  rest.add(restNew);
}
bool isFind=false;
for (var i = 0; i < rest.length; i++) {
  if (rest[i]['key']==index) {
    setState(() {
      
    isFind=true;
    });
    if (label=='Start Time') {
      
    rest[i]['start_time']=controller.text;
    }else{

    rest[i]['end_time']=controller.text;
    }
    break;
    
  } 
}
if (isFind) {
 }else{
  rest.add(restNew);
}


       }
      //  ------------------------------BOTTLE OBJECT----------------------
       else if(Object=='Bottle'){

Map<String,dynamic> bottleNew={
'key':index,
'time':"none",
'ML':"none",
'type':"none",
};
if (bottle.length<=0) {
  bottle.add(bottleNew);
}
bool isFind=false;
for (var i = 0; i < bottle.length; i++) {
  if (bottle[i]['key']==index) {
    setState(() {
      bottle[i]['time']=controller.text;
    isFind=true;
    });
    break;
    
  } 
}
if (isFind) {
 }else{
  bottle.add(bottleNew);
}



// VITAMIN
       }
       else if(Object=='Vitamin'){

Map<String,dynamic> vitaminNew={
'key':index,
'vitamin_name':"none",
'amount':"none",
'time':"none",
};
if (vitamin.length<=0) {
  vitamin.add(vitaminNew);
}
bool isFind=false;
for (var i = 0; i < vitamin.length; i++) {
  if (vitamin[i]['key']==index) {
    setState(() {
      vitamin[i]['time']=controller.text;
    isFind=true;
    });
    break;
    
  } 
}
if (isFind) {
}else{
  vitamin.add(vitaminNew);
}


       }
      });
    }
  }

  Widget _buildRestEntry(int index) {
    final RestEntry restEntry = _restEntries[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            'Rest Entry ${index + 1}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        _buildTimeField(restEntry.startController, 'Start Time', Icons.access_time,index,"Rest"),
        _buildTimeField(restEntry.endController, 'End Time', Icons.access_time,index,"Rest"),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    
print(widget.anak);
      return Scaffold(
      appBar: AppBar(
        title: Text(
          'Input Child Activity for ${ widget.anak[0]['nama_lengkap']}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildSectionTitle('Child Activity Information:'),
              _buildTextField(_namaAnakController, 'Child Name', Icons.child_care,0,true,'Name'),
              _buildDateField(_tanggalController, 'Date', Icons.calendar_today, _selectDate),
              _buildTimeField(_arrivalController, 'Arrival Time', Icons.access_time,0,'Arrival'),
              _buildTextField(_bodyTemperatureController, 'Body Temperature', Icons.thermostat,0,true,'Body'),
              _buildTextField(_conditionsController, 'Conditions', Icons.health_and_safety,0,true,'Kondisi'),
              SizedBox(height: 20),
              Divider(color: Colors.grey),
              _buildSectionTitle('Meals:'),
              _buildMealSection('Breakfast', 0),
              _buildMealSection('Snack', 1),
              _buildMealSection('Lunch', 2),
              _buildMealSection('Dinner', 3),
              _buildMealSection('Fluids', 4),
              _buildMealSection('Other', 5),
              Divider(color: Colors.grey),
              _buildSectionTitle('Toilet:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < _toiletEntries.length; i++)
                    _buildToiletEntry(i),
                  ElevatedButton(
                    onPressed: _addNewToiletEntry,
                    child: Text('Add Toilet Entry'),
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              _buildSectionTitle('Rest:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < _restEntries.length; i++)
                    _buildRestEntry(i),
                  ElevatedButton(
                    onPressed: _addNewRestEntry,
                    child: Text('Add Rest Entry'),
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              _buildSectionTitle('Bottle:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < _bottleEntries.length; i++)
                    _buildBottleEntry(i),
                  ElevatedButton(
                    onPressed: _addNewBottleEntry,
                    child: Text('Add Bottle Entry'),
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              _buildSectionTitle('Shower:'),
              _buildTimeField(_showerMorningController, 'Morning Shower Time', Icons.shower,0,'Shower'),
              _buildTimeField(_showerEveningController, 'Evening Shower Time', Icons.shower,0,'Shower'),
              Divider(color: Colors.grey),
              _buildSectionTitle('Vitamins:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < _vitaminEntries.length; i++)
                    _buildVitaminEntry(i),
                  ElevatedButton(
                    onPressed: _addNewVitaminEntry,
                    child: Text('Add Vitamin Entry'),
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              _buildSectionTitle('Items I Need:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _itemNeeds.keys.map<Widget>((key) {
                
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: _itemNeeds[key]['checked'],
                          onChanged: (bool? newValue) {
                            setState(() {
  
Map<String,dynamic> itemneedNew={
'key':key,

'quantity':"none",
};
if (itemneed.length>0) {
bool isFind=false;
for (var i = 0; i < itemneed.length; i++) {
  if (itemneed[i]['key']==key) {
    setState(() {
      
    isFind=true;
    itemneed.removeAt(i);
    });
      
    
    break;
    
  } 
}
if (isFind) {
}else{
    itemneed.add(itemneedNew);
}
}else{

  itemneed.add(itemneedNew);
}

              
                       indexItemneed+=1;  

    
                              _itemNeeds[key]['checked'] = newValue!;
                              
                              _itemNeeds[key]['visible'] = newValue;
                              
                            });
                          },
                        ),
                        Expanded(
                          child: Text(key),
                        ),
                        if (key == 'Other' && _itemNeeds[key]['checked'])
                          Expanded(
                            child: TextField(
                              onChanged: (index){
                                for (var i = 0; i < itemneed.length; i++) {
                                  if (itemneed[i]['name']=='Other') {
                                    itemneed[i]['name_other']=_otherItemController.text;
                                  }
                                }
                              },
                              controller: _otherItemController,
                              decoration: InputDecoration(
                                labelText: 'Specify Other Item',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        if (key != 'Other' && _itemNeeds[key]['visible'])
                          Expanded(
                            child: _buildDropdownField(
                              key,
                              'Quantity',
                              Icons.shopping_cart,
                              
                              List<String>.generate(100, (index) => (index + 1).toString()),
                              
                              _itemNeeds[key]['quantity'],
                                  (newValue) {
                                setState(() {


                                  _itemNeeds[key]['quantity'] = newValue!;
                                });
                              },
                              "ItemNeed"
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: updateDataAnak,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon,int index,bool isSingle,String Object) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        onChanged: (value){
if (isSingle==false) {
if (Object=='Meals') {
    
Map<String,dynamic> Item={
'key':index,
'Food':"none",
'Comment':"none",
'Quantity':'none',
};
if (meals.length<=0) {
  meals.add(Item);
}
bool isFind=false;
for (var i = 0; i < meals.length; i++) {
  if (meals[i]['key']==index) {
    setState(() {
      
    isFind=true;
    });
    if (label=='Food') {
    meals[i]['Food']=controller.text;
    }
    if (label=='Comment') {
      
    meals[i]['Comment']=controller.text;
    }
    if (label=='Quantity') {
    meals[i]['Quantity']=controller.text;
    }
    break;
    
  } 
}
if (isFind) {
}else{
  meals.add(Item);
}
}
// TOILET
else if(Object=='Toilet'){

Map<String,dynamic> toiletNew={
'key':index,
'entry':"none",
'type':"none",
'kondisi':'none',
'notes':controller.text,
};
if (toilet.length<=0) {
  toilet.add(toiletNew);
}
bool isFind=false;
for (var i = 0; i < toilet.length; i++) {
  if (toilet[i]['key']==index) {
    setState(() {
      
    isFind=true;
    });
    if (label=='Notes') {
    toilet[i]['notes']=controller.text;
    }
    break;
    
  } 
}
if (isFind) {
}else{
  toilet.add(toiletNew);
}
}


// VITAMINNN

else if(Object=='Vitamin'){

Map<String,dynamic> vitaminNew={
'key':index,
'vitamin_name':"none",
'amount':"none",
'time':'none',
};
if (vitamin.length<=0) {
  vitamin.add(vitaminNew);
}
bool isFind=false;
for (var i = 0; i < vitamin.length; i++) {
  if (vitamin[i]['key']==index) {
    setState(() {
      
    isFind=true;
    if (label=="Vitamin Name") {
      
    vitamin[i]['vitamin_name']=controller.text;
    }else{
    vitamin[i]['amount']=controller.text;

    }
    
    });
    break;
    
  } 
}
if (isFind) {
}else{
  vitamin.add(vitaminNew);
}
}



// Bottle

else if(Object=='Bottle'){

Map<String,dynamic> bottleNew={
'key':index,
'time':"none",
'ML':"none",
'type':'none',

};
if (bottle.length<=0) {
  bottle.add(bottleNew);
}
bool isFind=false;
for (var i = 0; i < bottle.length; i++) {
  if (bottle[i]['key']==index) {
    setState(() {
      
    isFind=true;
    bottle[i]['ML']=controller.text;
    });
    break;
    
  } 
}
if (isFind) {
}else{
  bottle.add(bottleNew);
}
}
}
        } ,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String label, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: widget.anak[0]['tanggal_lahir'],
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeField(TextEditingController controller, String label, IconData icon,int index,String Object) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: () {

        _selectTime(controller,index,Object,label);
        }, 
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(dynamic index,String label, IconData icon, List<String> options, String currentValue, ValueChanged<String?> onChanged,String Object ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InputDecorator(
        
        decoration: InputDecoration(
          labelText: label,
          
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: currentValue,
            isDense: true,
            
            onChanged: (value){
if (Object=='Meals') {


Map<String,dynamic> mealsNew={
'key':index,
'Food':"None",
'Comment':"None",
'Quantity':'None',

};
if (meals.length<=0) {

  meals.add(mealsNew);
}else{
}
bool isFind=false;
for (var i = 0; i < meals.length; i++) {
  if (meals[i]['key']==index) {
    setState(() {
      
    isFind=true;
    print(value);
    meals[i]['Quantity']=value;
    });

    break;
    
  } 
}
if (isFind) {
}else{
  meals.add(mealsNew);
}



}

if (Object=="Toilet") {
  
Map<String,dynamic> toiletNew={
'key':index,
'waktu':"none",
'type':"none",
'kondisi':'none',
'notes':'none',
};
if (toilet.length<=0) {
  toilet.add(toiletNew);
}
bool isFind=false;
for (var i = 0; i < toilet.length; i++) {
  if (toilet[i]['key']==index) {
    setState(() {
      
    isFind=true;
    });
    if (label=='Type') {
    toilet[i]['type']=value;
    }else
    if (label=='Condition') {
    toilet[i]['kondisi']=value;
    }
    break;
    
  } 
}
if (isFind) {
}else{
  toilet.add(toiletNew);
}
}



// BOTTOL
if (Object=="Bottle") {
  
Map<String,dynamic> bottleNew={
'key':index,
'time':"none",
'ML':"none",
'type':'none',

};
if (bottle.length<=0) {
  bottle.add(bottleNew);
}
bool isFind=false;
for (var i = 0; i < bottle.length; i++) {
  if (bottle[i]['key']==index) {
    setState(() {
      
    isFind=true;
    bottle[i]['type']=value;
    });
    break;
    
  } 
}
if (isFind) {
}else{
  bottle.add(bottleNew);
}
}

// ITEM NEED
if (Object=="ItemNeed") {
  var quantityFinal="1";
  
bool isFind=false;
for (int i = 0; i < itemneed.length; i++) {
  if (itemneed[i]['key']==index) {
    
    setState(() {
    isFind=true;
    itemneed[i]['quantity']=value.toString();
    quantityFinal=value.toString();
    });
  
    break;
    }
    
  } 

if (isFind) {
}else{
  // itemneed.add(itemneedNew);
}
}
            },
            items: options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildMealSection(String mealType, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            mealType,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        _buildTextField(_mealFoodControllers[index], 'Food', Icons.restaurant_menu,index,false,"Meals"),
        _buildDropdownField(index,
          'Quantity',
          Icons.restaurant,
          ['None', 'Some', 'Lots'],
          _mealQuantities[index],
              (newValue) {
            setState(() {
              Map<String,dynamic> Item={
'key':index,
'Food':"none",
'Comment':"none",
'Quantity':'none',
};
if (meals.length<=0) {
  meals.add(Item);
}
bool isFind=false;
for (var i = 0; i < meals.length; i++) {
  if (meals[i]['key']==index) {
meals[i]['Quantity']=newValue;
  } else {
    // meals.add(Item);
    
  }
}


              _mealQuantities[index] = newValue!;
            });
          },"Meals"
        ),
        _buildTextField(_mealCommentControllers[index], 'Comment', Icons.comment,index,false,"Meals"),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildToiletEntry(int index) {
    final ToiletEntry toiletEntry = _toiletEntries[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            'Toilet Entry ${index + 1}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        _buildTimeField(toiletEntry.timeController, 'Time', Icons.access_time,index,"Toilet"),
        _buildDropdownField(index,
          'Type',
          Icons.wc,
          ['Diaper', 'Potty'],
          toiletEntry.type,
              (newValue) {
            setState(() {
              toiletEntry.type = newValue!;
            });
          },"Toilet"
        ),
        _buildDropdownField(index,
          'Condition',
          Icons.wc,
          ['DR', 'Wet', 'BM'],
          toiletEntry.condition,
              (newValue) {
            setState(() {
              toiletEntry.condition = newValue!;
            });
          },"Toilet"
        ),
        _buildTextField(toiletEntry.notesController, 'Notes', Icons.notes,index,false,"Toilet"),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildBottleEntry(int index) {
    final BottleEntry bottleEntry = _bottleEntries[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            'Bottle Entry ${index + 1}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        _buildTimeField(bottleEntry.timeController, 'Time', Icons.access_time,index,"Bottle"),
        _buildTextField(bottleEntry.mlController, 'ML', Icons.local_drink,index,false,'Bottle'),
        _buildDropdownField(index,
          'Type',
          Icons.local_drink,
          ['Breast', 'Formula'],
          bottleEntry.type,
              (newValue) {
            setState(() {
              bottleEntry.type = newValue!;
            });
          },"Bottle"
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildVitaminEntry(int index) {
    final VitaminEntry vitaminEntry = _vitaminEntries[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            'Vitamin Entry ${index + 1}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        _buildTextField(vitaminEntry.nameController, 'Vitamin Name', Icons.local_pharmacy,index,false,'Vitamin'),
        _buildTextField(vitaminEntry.amountController, 'Amount', Icons.local_offer,index,false,'Vitamin'),
        _buildTimeField(vitaminEntry.timeController, 'Time', Icons.access_time,index,"Vitamin"),
        SizedBox(height: 10),
      ],
    );
  }
}

