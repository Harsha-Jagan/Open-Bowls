//import 'package:frontend/pages/authenticate/profile_setup_two.dart';
import 'package:flutter/material.dart';
import 'package:frontend/classes/user.dart';
import 'package:frontend/pages/home_wrapper.dart';
import 'package:frontend/pages/services/database.dart';
import 'package:provider/provider.dart';

//Profile Setup 1
//Form not validated
class CompleteProfOne extends StatefulWidget {
  const CompleteProfOne({super.key});

  @override
  State<CompleteProfOne> createState() => _CompleteProfOneState();
}

class _CompleteProfOneState extends State<CompleteProfOne> {
  final _formkey = GlobalKey<FormState>();
  String fname = "fname";
  String lname = "lname";
  int age = 0;
  double weight = 0.0;
  var _value1 = "Gender";
  var _value2 = "Race";
  bool _value3 = false;
  bool _value4 = false;
  bool _value5 = false;
  bool _value6 = false;
  var _value7 = "Sexual Orientation";
  bool _value8 = false;
  String height = "height";
  int durationHomeless = 0;
  @override
  Widget build(BuildContext context) {
    final per = Provider.of<Customer>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 195, 216),
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
        backgroundColor: const Color.fromARGB(255, 184, 195, 216),
      ),
      body: ListView(
        children: [
          const Text("Profile Setup",
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 1, 1, 12),
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "First Name",
                    hintText: "Please Enter your First Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                  onChanged: (val) {
                    setState(() => fname = val);
                  },
                  validator: (val) =>
                      val != null && val.isEmpty ? 'Enter a name' : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Last Name",
                    hintText: "Please Enter your Last Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                  onChanged: (val) {
                    setState(() => lname = val);
                  },
                  validator: (val) =>
                      val != null && val.isEmpty ? 'Enter a name' : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Age",
                      hintText: "Please Enter your age",
                      prefixIcon: Icon(Icons.date_range),
                    ),
                    validator: (val) =>
                        val != null && val.isEmpty ? 'Enter a number' : null,
                    onChanged: (val) {
                      setState(() => age = int.tryParse(val) ?? 0);
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Weight",
                      hintText: "Please Enter your weight (in lbs)",
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (val) =>
                        val != null && val.isEmpty ? 'Enter a number' : null,
                    onChanged: (val) {
                      setState(() => weight = double.tryParse(val) ?? 0);
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Height",
                      hintText: "Please Enter your height",
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (val) =>
                        val != null && val.isEmpty ? 'Enter a number' : null,
                    onChanged: (val) {
                      setState(() => height = val);
                    }),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: "Gender",
                        hintText: "Please Select your Gender:"),
                    value: _value1,
                    items: const [
                      DropdownMenuItem(
                          value: "Gender", child: Text("Select Gender")),
                      DropdownMenuItem(value: "Woman", child: Text("Woman")),
                      DropdownMenuItem(value: "Man", child: Text("Man")),
                      DropdownMenuItem(
                          value: "Transgender", child: Text("Transgender")),
                      DropdownMenuItem(
                          value: "Non Binary", child: Text("Non Binary")),
                      DropdownMenuItem(
                          value: "Other/Prefer not to say",
                          child: Text("Other/Prefer not to say"))
                    ],
                    onChanged: (String? newValue) {
                      setState(() => _value1 = newValue!);
                    }),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Sexual Orientation",
                    hintText: "Please Select your sexual orientation:",
                  ),
                  value: _value7 == "Sexual Orientation"
                      ? null
                      : _value7, // This line is changed
                  items: const [
                    DropdownMenuItem(
                        value: "Select sexual orientation",
                        child: Text("Select sexual orientation")),
                    DropdownMenuItem(value: "Gay", child: Text("Gay")),
                    DropdownMenuItem(value: "Lesbian", child: Text("Lesbian")),
                    DropdownMenuItem(
                        value: "Bisexual", child: Text("Bisexual")),
                    DropdownMenuItem(
                        value: "Heterosexual", child: Text("Heterosexual")),
                    DropdownMenuItem(
                        value: "Other/Prefer not to say",
                        child: Text("Other/Prefer not to say")),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null &&
                        newValue != "Select sexual orientation") {
                      // This logic ensures that an actual value has been selected
                      setState(() => _value7 = newValue);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText:
                          "For how long have you been experiencing homelessness?",
                      hintText:
                          "Please Enter the number of weeks. If you are currently not experiencing homelessness, please enter 0.",
                      prefixIcon: Icon(Icons.date_range),
                    ),
                    validator: (val) =>
                        val != null && val.isEmpty ? 'Enter a number' : null,
                    onChanged: (val) {
                      setState(() => durationHomeless = int.tryParse(val) ?? 0);
                    }),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: "Race",
                        hintText: "Please Select your Race:"),
                    value: _value2,
                    items: const [
                      DropdownMenuItem(
                          value: "Race", child: Text("Select Race")),
                      DropdownMenuItem(value: "White", child: Text("White")),
                      DropdownMenuItem(
                          value: "Black or African American",
                          child: Text("Black or African American")),
                      DropdownMenuItem(
                          value: "American Indian or Alaska Native",
                          child: Text("American Indian or Alaska Native")),
                      DropdownMenuItem(value: "Asian", child: Text("Asian")),
                      DropdownMenuItem(
                          value: "Native Hawaiian or Other Pacific Islander",
                          child: Text(
                              "Native Hawaiian or Other Pacific Islander")),
                      DropdownMenuItem(
                          value: "Prefer not to say",
                          child: Text("Prefer not to say"))
                    ],
                    onChanged: (String? newValue) {
                      setState(() => _value2 = newValue!);
                    }),
              ],
            ),
          ),
          SwitchListTile(
              title: const Text("Do you have any children?"),
              value: _value3,
              onChanged: (bool? newValue) {
                setState(() {
                  _value3 = newValue!;
                });
              }),
          const SizedBox(height: 30),
          SwitchListTile(
              title: const Text("Do you have any pets?"),
              value: _value4,
              onChanged: (bool? newValue) {
                setState(() {
                  _value4 = newValue!;
                });
              }),
          const SizedBox(height: 30),
          SwitchListTile(
              title: const Text("Do you have any disabilites?"),
              value: _value5,
              onChanged: (bool? newValue) {
                setState(() {
                  _value5 = newValue!;
                });
              }),
          const SizedBox(height: 30),
          SwitchListTile(
              title: const Text("Are you a veteran?"),
              value: _value6,
              onChanged: (bool? newValue) {
                setState(() {
                  _value6 = newValue!;
                });
              }),
          const SizedBox(height: 30),
          SwitchListTile(
              title:
                  const Text("Do you currently struggle with substance use?"),
              value: _value8,
              onChanged: (bool? newValue) {
                setState(() {
                  _value8 = newValue!;
                });
              }),
          const SizedBox(height: 90),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(children: [
            Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip: 'Go to previous page: Register',
                  heroTag: null,
                  child: const Icon(Icons.chevron_left),
                )),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    await DbService(uid: per.uid).updateUSerData(
                        fname,
                        lname,
                        age,
                        _value1,
                        _value7,
                        _value2,
                        durationHomeless,
                        _value3,
                        _value4,
                        _value5,
                        _value6,
                        _value8,
                        weight,
                        height);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Wraphome()),
                    );
                  }
                },
                tooltip: 'Submit',
                heroTag: null,
                child: const Text("Submit",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 1, 1, 12),
                    )),
              ),
            ),
          ])),
    );
  }
}
