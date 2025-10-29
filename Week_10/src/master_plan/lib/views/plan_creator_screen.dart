import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import '../provider/plan_provider.dart';
import './plan_screen.dart'; // Import PlanScreen

class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({super.key});

  @override
  State<PlanCreatorScreen> createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  // Langkah 13: Method untuk menambah Plan baru
  void addPlan(BuildContext context) {
    final text = textController.text;
    if (text.isEmpty) {
      return;
    }
    final plan = Plan(name: text, tasks: const []);
    
    // Ambil List<Plan> global
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    
    // Tambahkan Plan baru ke List global
    planNotifier.value = List<Plan>.from(planNotifier.value)..add(plan); 
    
    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {}); // Panggil setState untuk rebuild list creator
  }

  // Langkah 11: Method build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Master Plans Rengga',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // Gunakan Builder untuk mendapatkan context yang benar
      body: Builder(
        builder: (context) {
          return Column(children: [
            _buildListCreator(context), // Kirim context ke method
            Expanded(child: _buildMasterPlans(context)) // Kirim context ke method
          ]);
        }
      ),
    );
  }

  // Langkah 12: Widget untuk input Plan baru
  Widget _buildListCreator(BuildContext context) { // Terima context
    return Padding(
       padding: const EdgeInsets.all(20.0),
       child: Material(
         color: Theme.of(context).cardColor,
         elevation: 10,
         child: TextField(
            controller: textController,
            decoration: const InputDecoration(
               labelText: 'Add a plan',
               contentPadding: EdgeInsets.all(20)),
            onEditingComplete: () => addPlan(context)), // Kirim context ke method
       ));
  }
  
  // Langkah 14: Widget untuk menampilkan daftar Master Plans
Widget _buildMasterPlans(BuildContext context) { // Terima context
  ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    List<Plan> plans = planNotifier.value;

    if (plans.isEmpty) {
      return Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           const Icon(Icons.note, size: 100, color: Colors.grey),
           Text('Anda belum memiliki rencana apapun.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall)
         ]);
    }
    return ListView.separated(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return ListTile(
              title: Text(plan.name),
              subtitle: Text(plan.completenessMessage),
              onTap: () {
                Navigator.of(context).push(
                   MaterialPageRoute(builder: (context) => // Gunakan context yang benar
                      PlanProvider(
                        notifier: planNotifier,
                        child: PlanScreen(plan: plan)
                      )
                   )
                );
              });
        },
        separatorBuilder: (context, index) => const Divider(),
    );
}
}