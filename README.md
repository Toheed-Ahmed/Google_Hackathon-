# OpsPilot AI - Enterprise Autonomous Multi-Agent Logistics Intelligence System

## System Overview
OpsPilot AI is a production-ready, multi-agent logistics intelligence system designed to ingest unstructured data, assess real-world business impacts, and autonomously simulate execution steps (like routing updates or pricing changes). It acts as an **Agentic Decision-Making and Risk-Aware Control System**, specifically engineered to handle the complexities of supply chain disruptions without blind automation.

This system is powered by Google Antigravity Multi-Agent Orchestration Engine, enabling:
- distributed agent reasoning
- structured JSON communication flow
- autonomous logistics decision simulation
- real-world operational modeling

## Why a Multi-Agent System (Instead of a Single LLM)?
Using a single LLM for complex operations is prone to hallucinations, blending context, and erratic actions. OpsPilot AI utilizes a multi-agent architecture to enforce:
- **Separation of Concerns:** Each agent has a specialized, narrow focus (e.g., *only* extract impacts, or *only* validate).
- **Auditability & Traceability:** By looking at the JSON log between agents, human supervisors can trace exactly *why* a specific operational change was executed.
- **Robustness:** A single LLM might force a decision on bad data. A multi-agent pipeline includes dedicated validation checkpoints to reject bad data safely.

## Architecture & Communication Protocols

- **Strict JSON Passing:** Agents communicate exclusively via structured JSON objects. The output of one agent becomes the *exact* input for the next agent. This ensures a clean, unbreakable chain of thought and eliminates plain text drift.

- **Antigravity Orchestration:** The Antigravity framework operates as the central nervous system, sequentially spinning up specialized prompts, passing the JSON state context, and enforcing the pipeline order.

- **Failure Handling & Fallback Logic:** The Validation Agent monitors the pipeline for ambiguity or low confidence. If `confidence < medium` or `fallback_required: true`, the Decision Agent bypasses automated system changes and safely defaults to human escalation.

- **Real-World Simulation:** The Simulation Agent prevents direct production harm by outputting mock API calls (e.g., `POST /api/routing/geofence`) and expected systemic deltas. This proves the logic works in a controlled, hackathon-ready sandbox.


## 🧠 Key Enhancements (Latest Version)
- Fully semantic multi-source reasoning (no keyword-based logic)
- Real-time Alert Agent for crisis detection (pre and post execution)
- Action-Oriented Intelligence layer for autonomous execution tracking
- Strict JSON state contracts across all agents
- Parallel execution engine (3–5 simultaneous logistics actions)
- Rollback-safe enterprise decision system
- Antigravity orchestration with full trace logging

## Full Agent Workflow
```text
5+ Multi-Source Inputs
↓
Ingestion Agent
↓
Conflict Detection Agent
↓
Insight Agent
↓
Impact Agent
↓
Alert Agent
↓
Action Intelligence Agent
↓
Constraint Agent
↓
Validation Agent
↓
Decision Agent
↓
Recommendation Agent
↓
Execution Agent (3–5 parallel actions)
↓
Monitoring Agent
↓
Rollback Agent
↓
Visualization Agent
```

## 🚨 Alert & Action Intelligence System
- Alert Agent detects system-wide logistics instability BEFORE execution
- Generates dynamic, context-aware crisis alerts (no static messages)
- Post-execution alerts confirm system recovery or failure
- Action Agent executes and tracks multi-step operational changes
- Ensures full traceability of decisions inside execution logs

## 📦 Execution Trace System
All workflow executions are stored in:
`mockdata/execution_trace.json`
- Each run is appended (never overwritten)
- Includes full agent-by-agent decision history
- Supports audit-ready AI transparency for evaluation

## Architecture & Communication Protocols
- **Strict JSON Passing:** Agents communicate exclusively via structured JSON objects. The output of one agent becomes the *exact* input for the next agent. This ensures a clean, unbreakable chain of thought and eliminates plain text drift.
- **Failure Handling & Fallback Logic:** The Validation Agent monitors the pipeline for ambiguity or low confidence. If `confidence < medium` or `fallback_required: true`, the Decision Agent bypasses automated system changes and safely defaults to human escalation.
- **Real-World Simulation:** The Simulation Agent prevents direct production harm by outputting mock API calls (e.g., `POST /api/routing/geofence`) and expected systemic deltas. This proves the logic works in a controlled, hackathon-ready sandbox.

## 📂 Project Structure
*   `workflows/` — Core Agentic logic and action-execution flows.
*   `prompts/` — SRE Personas and decision-making frameworks.
*   `mobile_app/` — Android interface for on-the-go monitoring and approvals.
*   `mock_data/` — Unstructured reports and simulated system logs for testing.
*   `docs/` — Technical documentation and pitch materials.

## 👥 Team Members
*   **Toheed Ahmed** — Lead Architect: Workflows & Prompts
*   **Muhammad Hasnain** — Core Agent Development
*   **Dua Ali** — Mobile Development & UI/UX
*   **Abdul Ahad** — Data Strategy & Mock Data
*   **Yasir Hafeez** — System Design & Documentation

---

## 📥 Getting Started

To get a local copy up and running, follow these steps:

```bash
# Clone the repository
git clone https://github.com/Toheed-Ahmed/OpsPilot_AI

# Enter the project directory
cd OpsPilot_AI

# Install dependencies
pip install -r requirements.txt
```
