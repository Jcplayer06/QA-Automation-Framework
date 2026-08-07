"""
AI-powered test analysis tool.

Parses a Robot Framework `output.xml` result file and produces a
human-readable stability report. If an OpenAI API key is available
(via the OPENAI_API_KEY environment variable), the run summary is
sent to an LLM to generate the risk assessment and coverage
suggestions. If no key is configured, a deterministic rule-based
report is generated instead, so the tool always works with no
external dependency required.
"""

import os
import xml.etree.ElementTree as ET
from pathlib import Path

from dotenv import load_dotenv

load_dotenv()

CANDIDATE_SUGGESTIONS = [
    "Empty Username",
    "Empty Password",
    "Invalid ZIP Code",
    "Multiple Item Checkout",
    "Remove Item Before Checkout",
    "Browser Refresh During Checkout",
    "Logout Verification",
]


class AIHelper:
    """Analyzes a Robot Framework output.xml and reports on test stability."""

    def __init__(self, output_xml_path: Path = None):
        self.output_xml_path = output_xml_path or (
            Path(__file__).parent.parent / "output.xml"
        )

    def _parse_results(self):
        """Returns a results dict parsed from output.xml, or None if missing."""
        if not self.output_xml_path.exists():
            return None

        root = ET.parse(self.output_xml_path).getroot()
        executed, failed_names = [], []
        passed = failed = 0

        for test in root.findall(".//test"):
            name = test.attrib.get("name")
            executed.append(name)

            status = test.find("status")
            if status is not None and status.attrib.get("status") == "PASS":
                passed += 1
            else:
                failed += 1
                failed_names.append(name)

        return {
            "total": passed + failed,
            "passed": passed,
            "failed": failed,
            "executed": executed,
            "failed_names": failed_names,
        }

    def _build_narrative(self, results):
        """
        Builds the report body as a single narrative string.

        Uses an LLM when OPENAI_API_KEY is set; otherwise falls back to a
        deterministic rule-based report. Always returns (narrative, source).
        """
        api_key = os.getenv("OPENAI_API_KEY")
        if api_key:
            narrative = self._ask_openai(results, api_key)
            if narrative:
                return narrative, "openai"

        return self._rule_based_narrative(results), "rule-based"

    def _ask_openai(self, results, api_key):
        """Returns an LLM-generated narrative, or None if the call fails."""
        try:
            from openai import OpenAI

            prompt = (
                "You are a QA analyst reviewing an automated test run.\n\n"
                f"Total tests: {results['total']}\n"
                f"Passed: {results['passed']}\n"
                f"Failed: {results['failed']}\n"
                f"Executed tests: {', '.join(results['executed'])}\n"
                f"Failed tests: {', '.join(results['failed_names']) or 'None'}\n\n"
                "Respond with:\n"
                "1. A stability score from 0-100.\n"
                "2. A one-line risk level (LOW, MEDIUM, or HIGH RISK) with a short reason.\n"
                "3. 3-5 additional test scenarios this suite is missing.\n"
                "Keep the whole response under 150 words."
            )

            response = OpenAI(api_key=api_key).chat.completions.create(
                model="gpt-4o-mini",
                messages=[{"role": "user", "content": prompt}],
                max_tokens=300,
            )
            return response.choices[0].message.content.strip()

        except Exception as exc:
            print(f"[ai_helper] OpenAI call failed, using fallback: {exc}")
            return None

    def _rule_based_narrative(self, results):
        """Formats a deterministic stability report as a narrative string."""
        failed = results["failed"]
        score = max(0, 100 - failed * 15)
        risk = "LOW RISK" if failed == 0 else "MEDIUM RISK" if failed <= 2 else "HIGH RISK"
        suggestions = [
            s for s in CANDIDATE_SUGGESTIONS if s not in results["executed"]
        ]

        lines = [
            f"Stability score : {score}%",
            f"Risk assessment : {risk}",
            "",
            "Suggested additional tests:",
        ]
        lines += [f"  - {s}" for s in suggestions] or ["  (none - good coverage)"]
        return "\n".join(lines)

    def analyze(self):
        """Parses output.xml and prints the full analysis report."""
        results = self._parse_results()
        if results is None:
            print(f"{self.output_xml_path} not found. Run the tests first.")
            return

        narrative, source = self._build_narrative(results)

        print("\n===================================")
        print("      AI TEST ANALYSIS REPORT")
        print("===================================\n")
        print(f"Tests Executed : {results['total']}")
        print(f"Passed         : {results['passed']}")
        print(f"Failed         : {results['failed']}")

        print("\nExecuted Tests:")
        for name in results["executed"]:
            marker = "x" if name in results["failed_names"] else "v"
            print(f"[{marker}] {name}")

        print(f"\nAnalysis ({source}):\n")
        print(narrative)

        if source == "rule-based":
            print(
                "\n(Set OPENAI_API_KEY in a .env file for AI-generated analysis.)"
            )


if __name__ == "__main__":
    AIHelper().analyze()
