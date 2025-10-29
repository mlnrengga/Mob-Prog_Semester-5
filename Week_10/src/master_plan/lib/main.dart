import 'package:flutter/material.dart';
import './views/plan_screen.dart';
import './provider/plan_provider.dart'; 
// import './models/plan.dart';
import './models/data_layer.dart';
import './views/plan_creator_screen.dart';

void main() => runApp(const MasterPlanApp());

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      theme: ThemeData(primarySwatch: Colors.purple),
      // State utama sekarang adalah List<Plan>
      home: PlanProvider(
        notifier: ValueNotifier<List<Plan>>(const []), // Inisialisasi List<Plan> kosong
        child: const PlanCreatorScreen(), // Home baru
      ),
    );
  }
}