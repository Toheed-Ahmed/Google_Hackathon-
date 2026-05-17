import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'result_screen.dart';

class FlowScreen extends StatefulWidget {
  final String userInput;
  final bool isAutonomousMode;
  const FlowScreen({super.key, required this.userInput, required this.isAutonomousMode});

  @override
  State<FlowScreen> createState() => _FlowScreenState();
}

class _FlowScreenState extends State<FlowScreen> with TickerProviderStateMixin {
  bool isProcessingComplete = false;
  List<dynamic>? traces;
  bool isLoadingData = true;
  int visibleAgentsCount = 0;
  String detectedDomain = "Evaluating Channels...";
  
  final List<String> _liveTerminalOutput = [];
  final ScrollController _terminalScrollController = ScrollController();

  late AnimationController _blinkController;
  bool _showCursor = true;

  @override
  void initState() {
    super.initState();
    _initBlinker();
    _initDataAndTimers();
  }

  void _initBlinker() {
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (mounted) {
            setState(() { _showCursor = !_showCursor; });
            _blinkController.forward(from: 0.0);
          }
        }
      });
    _blinkController.forward();
  }

  @override
  void dispose() {
    _terminalScrollController.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  String _determineOptimalWorkflowId(String input) {
    final String text = input.toLowerCase();
    int weatherScore = 0;
    int logisticsScore = 0;
    int financialScore = 0;

    if (text.contains('rain') || text.contains('flood') || text.contains('weather') || text.contains('multi')) weatherScore += 10;
    if (text.contains('port') || text.contains('strike') || text.contains('block') || text.contains('export')) logisticsScore += 5;
    if (text.contains('fuel') || text.contains('price') || text.contains('cost') || text.contains('margin')) financialScore += 5;

    if (weatherScore >= logisticsScore && weatherScore >= financialScore) {
      detectedDomain = "Multi-Source Environment Vector";
      return 'OP-SYNC-9003';
    } else if (logisticsScore >= financialScore) {
      detectedDomain = "Logistics Infrastructure Vector";
      return 'OP-SYNC-9001';
    } else {
      detectedDomain = "National Financial Security Vector";
      return 'OP-SYNC-9002';
    }
  }

  Future<void> _initDataAndTimers() async {
    try {
      final String response = await rootBundle.loadString('assets/execution_trace.json');
      final List<dynamic> workflows = json.decode(response);
      
      String optimalWorkflowId = _determineOptimalWorkflowId(widget.userInput);
      dynamic selectedWorkflow = workflows.firstWhere(
        (w) => w['workflow_id'] == optimalWorkflowId,
        orElse: () => workflows[0]
      );

      if (mounted) {
        setState(() {
          traces = selectedWorkflow['execution_trace'] ?? [];
          isLoadingData = false;
        });
        _startReasoningSequence();
      }
    } catch (e) {
      debugPrint("Bypass protection active: $e");
      _loadFallbackData();
    }
  }

  void _loadFallbackData() {
    setState(() {
      detectedDomain = "Simulation Backup Active";
      traces = [
        {"agent": "Ingestion Agent", "terminal_logs": ["[FETCH] Core stream online."], "output": null},
        {"agent": "Alert Agent", "terminal_logs": ["[WARN] Threshold breach logged."], "output": null},
        {"agent": "Execution Agent", "terminal_logs": ["[EXEC] Fallback routing parameters deployed."], "output": null}
      ];
      isLoadingData = false;
    });
    _startReasoningSequence();
  }

  void _startReasoningSequence() async {
    if (traces == null || traces!.isEmpty) return;
    for (int i = 0; i < traces!.length; i++) {
      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted) {
        setState(() {
          visibleAgentsCount = i + 1;
          var agentLogs = traces![i]['terminal_logs'];
          if (agentLogs != null && agentLogs is List) {
            for (var log in agentLogs) {
              _liveTerminalOutput.add(log.toString());
            }
          } else {
            _liveTerminalOutput.add("[INFO] Invoking ${traces![i]['agent']} computational model...");
          }
        });
        
        _terminalScrollController.animateTo(
          _terminalScrollController.position.maxScrollExtent + 40,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    }
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) setState(() { isProcessingComplete = true; });
  }

  String _getAgentDescription(String agentName, dynamic output) {
    if (output == null) return "Execution logic successfully processed and trace checkpoint committed.";
    try {
      if (agentName.contains("Execution Agent")) {
        var updates = output['system_updates'];
        var results = output['execution_results'];
        String modeMsg = widget.isAutonomousMode 
          ? (results?['ACTIVE_MODE_ACTION'] ?? "Committed Live Backend Payload.")
          : (results?['SHADOW_MODE_ACTION'] ?? "Holding verification execution vector.");
        return "$modeMsg\nUpdates: ${updates != null ? updates.toString() : 'Synchronized.'}";
      }
      switch (agentName) {
        case "Ingestion Agent":
          return "Sources Processed: ${output['global_context']?['total_sources_processed']}. Risk Level assigned: ${output['global_context']?['system_risk_level']}";
        case "Alert Agent":
          return "🚨 Message: ${output['alert_message']}\nScope: ${output['risk_type'] ?? 'General'} Status: ${output['propagation_status'] ?? 'Active'}";
        case "Insight Agent":
          var list = output['insights'];
          return list != null ? "Core Issue: ${list[0]['core_issue']}" : "Insight matrix generated.";
        case "Impact Agent":
          var analysis = output['impact_analysis'];
          return analysis != null ? "Financial Loss Index: ${analysis[0]['financial_impact']}\nUrgency: ${analysis[0]['urgency_score']}/100" : "Risks evaluated.";
        case "Constraint Agent":
          var ce = output['constraint_evaluation'];
          return "Constraints Identified: ${ce?['resource_constraints']?.join(', ') ?? 'Loaded.'}\nAllowed Pathway: ${ce?['feasible_operations']?.join(', ') ?? 'None'}";
        case "Visualization Agent":
          return "Status: ${output['dashboard_summary']?['system_status'] ?? 'SYNCED'}\nResolutions: ${output['dashboard_summary']?['resolved_issues']?.join(', ') ?? 'Metrics Updated.'}";
        default:
          return "Antigravity Multi-Agent transaction processed and verified successfully.";
      }
    } catch (e) {
      return "Agent processing trace complete. State variables synchronized securely.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030712),
      appBar: AppBar(
        title: const Text('Antigravity Pipeline Tracker', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: 0.5)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoadingData 
        ? const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6))) 
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937).withOpacity(0.3), 
                    borderRadius: BorderRadius.circular(16), 
                    border: Border.all(color: Colors.white.withOpacity(0.04))
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.analytics_outlined, color: Color(0xFF60A5FA), size: 20),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("ACTIVE COORDINATION NODE:", style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
                            const SizedBox(height: 3),
                            Text(detectedDomain, style: const TextStyle(color: Color(0xFF34D399), fontSize: 13, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Agent Track Flow with Clean Transitions
              Expanded(
                flex: 3,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: traces!.length,
                  itemBuilder: (context, index) {
                    final traceItem = traces![index];
                    final String agentName = traceItem['agent'] ?? 'Unknown Agent';
                    bool isAlert = agentName.contains("Alert");

                    if (index >= visibleAgentsCount) {
                      if (index == visibleAgentsCount) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                          child: Row(
                            children: [
                              const SizedBox(height: 12, width: 12, child: CircularProgressIndicator(strokeWidth: 1.5, color: Color(0xFF3B82F6))),
                              const SizedBox(width: 14),
                              Text("Resolving $agentName layers...", style: TextStyle(color: Colors.grey[500], fontStyle: FontStyle.italic, fontSize: 12)),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }

                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 350),
                      opacity: 1.0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                        decoration: BoxDecoration(
                          color: isAlert ? const Color(0xFF7F1D1D).withOpacity(0.15) : const Color(0xFF111827),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: isAlert ? const Color(0xFFEF4444).withOpacity(0.2) : Colors.white.withOpacity(0.04)),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            leading: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: isAlert ? const Color(0xFFEF4444).withOpacity(0.1) : const Color(0xFF10B981).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isAlert ? Icons.crisis_alert_rounded : Icons.check_circle_rounded, 
                                color: isAlert ? const Color(0xFFF87171) : const Color(0xFF34D399), 
                                size: 16
                              ),
                            ),
                            title: Text(agentName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13, letterSpacing: 0.2)),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_getAgentDescription(agentName, traceItem['output']), style: TextStyle(color: Colors.grey[300], fontSize: 12, height: 1.5)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Icon(Icons.terminal_outlined, color: Colors.white38, size: 14),
                      const SizedBox(width: 6),
                      Text("LIVE ENGINE PROCESS CORE MONITOR:", style: TextStyle(color: Colors.grey[600], fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
                    ],
                  ),
                ),
              ),

              // --- COMPONENT OVERHAUL: NEON STREAM TERMINAL ---
              Container(
                height: 125,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF010409), 
                  borderRadius: BorderRadius.circular(16), 
                  border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withOpacity(0.04),
                      blurRadius: 14,
                      spreadRadius: 1,
                    )
                  ]
                ),
                child: ListView.builder(
                  controller: _terminalScrollController,
                  itemCount: _liveTerminalOutput.isEmpty ? 1 : _liveTerminalOutput.length,
                  itemBuilder: (context, idx) {
                    if (_liveTerminalOutput.isEmpty) {
                      return Row(
                        children: [
                          const Text("\$ stabilizing trace channels", style: TextStyle(color: Colors.blueGrey, fontSize: 11, fontFamily: 'monospace')),
                          if (_showCursor) const Text("_", style: TextStyle(color: Colors.blueGrey, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      );
                    }
                    
                    bool isLastLine = idx == _liveTerminalOutput.length - 1;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              _liveTerminalOutput[idx], 
                              style: const TextStyle(color: Color(0xFF34D399), fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.w500)
                            ),
                          ),
                          if (isLastLine && _showCursor && !isProcessingComplete)
                            const Text(" ▋", style: TextStyle(color: Color(0xFF34D399), fontSize: 10)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Bottom Navigation Sheet
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A), 
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  border: Border.all(color: Colors.white.withOpacity(0.02)),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      disabledBackgroundColor: Colors.white.withOpacity(0.02),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    onPressed: isProcessingComplete 
                      ? () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(userInput: widget.userInput, isAutonomousMode: widget.isAutonomousMode)));
                        } 
                      : null, 
                    child: Text(
                      isProcessingComplete 
                        ? (widget.isAutonomousMode ? "Commit Operational Parameters" : "Review Mitigation Blueprints")
                        : "Synthesizing Pipeline Sequences...",
                      style: TextStyle(color: isProcessingComplete ? Colors.white : Colors.white24, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}