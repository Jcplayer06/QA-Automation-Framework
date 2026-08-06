import xml.etree.ElementTree as ET
from pathlib import Path


class AIHelper:

    def analyze(self):

        xml_file = Path(__file__).parent.parent / "output.xml"

        if not xml_file.exists():
            print("output.xml not found.")
            return

        tree = ET.parse(xml_file)
        root = tree.getroot()

        tests = root.findall(".//test")

        passed = 0
        failed = 0

        executed = []

        for test in tests:

            name = test.attrib.get("name")

            executed.append(name)

            status = test.find("status")

            if status.attrib["status"] == "PASS":
                passed += 1
            else:
                failed += 1

        total = passed + failed

        score = max(0, 100 - failed * 15)

        print("\n===================================")
        print("      AI TEST ANALYSIS REPORT")
        print("===================================\n")

        print(f"Tests Executed : {total}")
        print(f"Passed         : {passed}")
        print(f"Failed         : {failed}")
        print(f"Stability      : {score}%")

        print("\nExecuted Tests:")

        for test in executed:
            print(f"✓ {test}")

        print("\nAI Suggested Additional Tests")

        suggestions = [
            "Empty Username",
            "Empty Password",
            "Locked User",
            "Invalid ZIP Code",
            "Multiple Item Checkout",
            "Remove Item Before Checkout",
            "Browser Refresh During Checkout",
            "Logout Verification"
        ]

        for suggestion in suggestions:

            if suggestion not in executed:
                print(f"• {suggestion}")

        print("\nRisk Assessment")

        if failed == 0:
            print("LOW RISK")
        elif failed <= 2:
            print("MEDIUM RISK")
        else:
            print("HIGH RISK")


if __name__ == "__main__":
    AIHelper().analyze()