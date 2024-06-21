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
  final String childName;

  ActivityInputScreen({required this.childName});

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

  @override
  void initState() {
    super.initState();
    _namaAnakController.text = widget.childName; // Mengisi nama anak dari parameter
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

  void _selectTime(TextEditingController controller) async {
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
        _buildTimeField(restEntry.startController, 'Start Time', Icons.access_time),
        _buildTimeField(restEntry.endController, 'End Time', Icons.access_time),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Input Child Activity for ${widget.childName}',
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
              _buildTextField(_namaAnakController, 'Child Name', Icons.child_care),
              _buildDateField(_tanggalController, 'Date', Icons.calendar_today, _selectDate),
              _buildTimeField(_arrivalController, 'Arrival Time', Icons.access_time),
              _buildTextField(_bodyTemperatureController, 'Body Temperature', Icons.thermostat),
              _buildTextField(_conditionsController, 'Conditions', Icons.health_and_safety),
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
              _buildTimeField(_showerMorningController, 'Morning Shower Time', Icons.shower),
              _buildTimeField(_showerEveningController, 'Evening Shower Time', Icons.shower),
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
                              'Quantity',
                              Icons.shopping_cart,
                              List<String>.generate(100, (index) => (index + 1).toString()),
                              _itemNeeds[key]['quantity'],
                                  (newValue) {
                                setState(() {
                                  _itemNeeds[key]['quantity'] = newValue!;
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _submitActivity(context),
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

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
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

  Widget _buildTimeField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: () => _selectTime(controller),
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

  Widget _buildDropdownField(String label, IconData icon, List<String> options, String currentValue, ValueChanged<String?> onChanged) {
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
            onChanged: onChanged,
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
        _buildTextField(_mealFoodControllers[index], 'Food', Icons.restaurant_menu),
        _buildDropdownField(
          'Quantity',
          Icons.restaurant,
          ['None', 'Some', 'Lots'],
          _mealQuantities[index],
              (newValue) {
            setState(() {
              _mealQuantities[index] = newValue!;
            });
          },
        ),
        _buildTextField(_mealCommentControllers[index], 'Comment', Icons.comment),
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
        _buildTimeField(toiletEntry.timeController, 'Time', Icons.access_time),
        _buildDropdownField(
          'Type',
          Icons.wc,
          ['Diaper', 'Potty'],
          toiletEntry.type,
              (newValue) {
            setState(() {
              toiletEntry.type = newValue!;
            });
          },
        ),
        _buildDropdownField(
          'Condition',
          Icons.wc,
          ['DR', 'Wet', 'BM'],
          toiletEntry.condition,
              (newValue) {
            setState(() {
              toiletEntry.condition = newValue!;
            });
          },
        ),
        _buildTextField(toiletEntry.notesController, 'Notes', Icons.notes),
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
        _buildTimeField(bottleEntry.timeController, 'Time', Icons.access_time),
        _buildTextField(bottleEntry.mlController, 'ML', Icons.local_drink),
        _buildDropdownField(
          'Type',
          Icons.local_drink,
          ['Breast', 'Formula'],
          bottleEntry.type,
              (newValue) {
            setState(() {
              bottleEntry.type = newValue!;
            });
          },
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
        _buildTextField(vitaminEntry.nameController, 'Vitamin Name', Icons.local_pharmacy),
        _buildTextField(vitaminEntry.amountController, 'Amount', Icons.local_offer),
        _buildTimeField(vitaminEntry.timeController, 'Time', Icons.access_time),
        SizedBox(height: 10),
      ],
    );
  }
}
