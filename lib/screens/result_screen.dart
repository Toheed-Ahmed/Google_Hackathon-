import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String userInput;
  final bool isAutonomousMode;
  const ResultScreen({super.key, required this.userInput, required this.isAutonomousMode});

  @override
  Widget build(BuildContext context) {
    final String text = userInput.toLowerCase();
    
    bool isWeatherScenario = text.contains('rain') || text.contains('flood') || text.contains('weather') || text.contains('multi');
    bool isFinancialScenario = text.contains('fuel') || text.contains('price') || text.contains('cost') || text.contains('margin');

    String scenarioTitle = "Disruption Vectors Remediated";
    List<String> beforeMetrics = [];
    List<String> afterMetrics = [];
    String carbonText = "0 metric tons";
    String carbonSummary = "No active ecological measurements available.";

    if (isWeatherScenario) {
      scenarioTitle = "Multi-Source Node Optimization";
      carbonText = "14.2 metric tons";
      carbonSummary = "High-density dynamic rerouting avoided 450 miles of idle traffic in flooded zones, reducing fuel burn completely.";
      beforeMetrics = [
        "Inbound Channels: Karachi Port completely locked by labor union strike.",
        "Fleet Assets: Last-mile delivery vehicles immobilized in flooded zones.",
        "Warehouse Target: Karachi Central node facing total stock-out in <12 hours."
      ];
      afterMetrics = [
        "Fleet Recovery: High-clearance tactical trucks deployed for critical triage.",
        "SLA Management: Standard constraints frozen safely under legal Force Majeure.",
        "Pipeline Protection: Incoming core inventory diverted safely via Hyderabad Depot."
      ];
    } else if (isFinancialScenario) {
      scenarioTitle = "Financial Vector Margin Protection";
      carbonText = "2.8 metric tons";
      carbonSummary = "Route consolidation reduced unnecessary delivery node cycles, protecting environmental indexes.";
      beforeMetrics = [
        "Market Surge: Abrupt 18% petroleum price escalation active nationwide.",
        "Margin Viability: High financial probability of erasing standard profit margins.",
        "Routing Engine: Standard routing routes operate with unoptimized pricing parameters."
      ];
      afterMetrics = [
        "Billing Execution: Operational margins secured via 8.5% dynamic fuel surcharge.",
        "Algorithmic Saving: Route efficiency targets improved by 10% via consolidation.",
        "Network State: Transportation variable costs stabilized across Pakistan."
      ];
    } else {
      scenarioTitle = "Infrastructure Disruption Resolved";
      carbonText = "14.0 metric tons";
      carbonSummary = "Port bypass operations optimized maritime idling fuel, reducing cost matrices.";
      beforeMetrics = [
        "Logistics Bottleneck: Karachi Port clearing actions stalled via union strike.",
        "Hub Vulnerability: Lahore raw stock drops dangerously below <15% threshold.",
        "Financial Threat: Immediate \$2,000,000/day revenue loss if lines shut down."
      ];
      afterMetrics = [
        "Maritime Overhaul: Target vessel successfully diverted to Port Qasim terminal.",
        "Supply Insurance: Lahore safety buffers reinforced via internal Multan fleet.",
        "Risk Eradicated: Revenue bleed index reduced to a safe minimum (\$150k mitigated)."
      ];
    }

    return Scaffold(
      backgroundColor: const Color(0xFF030712),
      appBar: AppBar(
        title: const Text('Outcome Simulation Tracker', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: 0.5)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(scenarioTitle, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.5)),
            const SizedBox(height: 6),
            Text(
              !isAutonomousMode 
                ? "PREVIEW MATRIX: Shadow logs active. Awaiting manager approval sequence."
                : "COMMIT CONFIRMED: Framework variations committed autonomously via Antigravity cores.",
              style: TextStyle(color: isAutonomousMode ? const Color(0xFF34D399) : const Color(0xFFF59E0B), fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.2),
            ),
            const SizedBox(height: 28),

            // --- DEGRADED CONTEXT CARD (BEFORE) ---
            _buildStateCard(
              title: "CRITICAL SYSTEM STATE (BEFORE)",
              icon: Icons.gpp_maybe_rounded,
              iconColor: const Color(0xFFF87171),
              bgColor: const Color(0xFF7F1D1D).withOpacity(0.08),
              borderColor: const Color(0xFFEF4444).withOpacity(0.15),
              content: beforeMetrics,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Center(child: Icon(Icons.arrow_downward_rounded, size: 24, color: Colors.white24)),
            ),

            // --- RECOVERED CONTEXT CARD (AFTER) ---
            _buildStateCard(
              title: "STABILIZED ORCHESTRATION OUTCOME (AFTER)",
              icon: Icons.verified_user_rounded,
              iconColor: const Color(0xFF34D399),
              bgColor: const Color(0xFF064E3B).withOpacity(0.12),
              borderColor: const Color(0xFF10B981).withOpacity(0.18),
              content: afterMetrics,
            ),

            const SizedBox(height: 28),

            // --- GLASSMORPhIC SUSTAINABILITY REPORT PANEL ---
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A).withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF14B8A6).withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Icon(Icons.bolt_sharp, color: Color(0xFF2DD4BF), size: 18),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "Antigravity Green Telemetry Metrics", 
                          style: TextStyle(color: Color(0xFF2DD4BF), fontWeight: FontWeight.w700, fontSize: 13, letterSpacing: 0.2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D9488).withOpacity(0.15), 
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF14B8A6).withOpacity(0.3))
                        ),
                        child: Text(
                          carbonText, 
                          style: const TextStyle(color: Color(0xFF2DD4BF), fontSize: 11, fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider(color: Colors.white10)),
                  Text(carbonSummary, style: TextStyle(color: Colors.grey[400], fontSize: 12, height: 1.5)),
                ],
              ),
            ),

            const SizedBox(height: 40),
            
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white.withOpacity(0.06)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text("Return to Systems Console", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 13, letterSpacing: 0.2)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required Color borderColor,
    required List<String> content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: iconColor, size: 16),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title, 
                  style: TextStyle(color: iconColor, fontWeight: FontWeight.w800, fontSize: 11, letterSpacing: 1.2),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white10, height: 24),
          ...content.map((text) => Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• ", style: TextStyle(color: iconColor.withOpacity(0.4), fontSize: 14)),
                Expanded(child: Text(text, style: const TextStyle(color: Color(0xFFF3F4F6), fontSize: 13, height: 1.5))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}