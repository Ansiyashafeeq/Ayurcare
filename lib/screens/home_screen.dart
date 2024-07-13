import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patientlist_provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch patient list when the home page is initialized
    Provider.of<PatientListProvider>(context, listen: false).fetchPatientList();
  }

  @override
  Widget build(BuildContext context) {
    final patientListProvider = Provider.of<PatientListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh the patient list
          await Provider.of<PatientListProvider>(context, listen: false).fetchPatientList();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Handle search button press
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: patientListProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : patientListProvider.patients.isEmpty
                    ? Center(child: Image.asset('assets/empty_list.png')) // Add your empty list image here
                    : ListView.builder(
                  itemCount: patientListProvider.patients.length,
                  itemBuilder: (context, index) {
                    final patient = patientListProvider.patients[index];
                    return ListTile(
                      title: Text(patient.name),
                      subtitle: Text('Appointment: ${patient.appointmentDate}'),
                      onTap: () {
                        // Handle patient list item tap
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
