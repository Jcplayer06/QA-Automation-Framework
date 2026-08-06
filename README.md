# AI-SDET Automation Framework

## Overview

This project is an automated UI testing framework developed as part of an SDET Technical Exercise. It demonstrates the use of **Robot Framework**, **Python**, and **SeleniumLibrary** for web UI automation using the SauceDemo website.

The framework follows a modular structure with reusable Robot Framework keywords, custom Python libraries, and organized test suites to promote maintainability, scalability, and code reusability.

---

# Technologies Used

- Robot Framework
- Python 3.14+
- SeleniumLibrary
- Microsoft Edge WebDriver
- Git

---

# Framework Features

- Login Automation
- Inventory Validation
- Cart Workflow
- Complete Checkout Workflow
- AI-Assisted Test Analysis
- Custom Python Libraries
- Modular Robot Framework Keywords
- Reusable Locators and Variables

---

# Project Structure

```
AI-SDET-Automation-Framework
│
├── libraries/
│   ├── ai_helper.py
│   ├── browser_helper.py
│   ├── logger.py
│   └── screenshot.py
│
├── pages/
│
├── resources/
│   ├── keywords.robot
│   ├── locators.robot
│   └── variables.robot
│
├── testdata/
│
├── tests/
│   ├── login.robot
│   ├── inventory.robot
│   ├── cart.robot
│   └── checkout.robot
│
├── README.md
├── requirements.txt
└── run_tests.bat
```

---

# Prerequisites

Before running the project, install the following:

- Python 3.14 or newer
- Microsoft Edge browser
- Git (optional)

---

# Setup

## Option 1 - Using a Virtual Environment (Recommended)

Create a virtual environment:

```powershell
python -m venv .venv
```

Activate it:

**PowerShell**

```powershell
.\.venv\Scripts\Activate.ps1
```

**Command Prompt**

```cmd
.venv\Scripts\activate.bat
```

Install dependencies:

```powershell
pip install -r requirements.txt
```

---

## Option 2 - Without a Virtual Environment

Install the required packages globally:

```powershell
pip install -r requirements.txt
```

---

# Running the Tests

Run all test suites:

```powershell
robot tests
```

Run individual test suites:

```powershell
robot tests/login.robot
```

```powershell
robot tests/inventory.robot
```

```powershell
robot tests/cart.robot
```

```powershell
robot tests/checkout.robot
```

---

# AI-Assisted Test Analysis

After executing the tests, run:

```powershell
python libraries/ai_helper.py
```

This analyzes the Robot Framework `output.xml` file and generates:

- Test execution summary
- Pass/Fail statistics
- Stability score
- AI-assisted recommendations for additional test coverage
- Risk assessment

---

# Browser Configuration

The automation framework is configured to use **Microsoft Edge**.

Although Selenium supports Google Chrome, Microsoft Edge was chosen because Chrome may display Password Manager or Password Check prompts during login automation. These browser dialogs can interfere with automated execution and produce inconsistent test results.

Using Microsoft Edge provides a more stable and predictable environment for the current test scenarios.

If you wish to use Google Chrome instead, update the browser configuration in:

```
resources/keywords.robot
```

Change:

```robot
Open Browser    ${BASE_URL}    edge
```

to:

```robot
Open Browser    ${BASE_URL}    chrome
```

If using Chrome, it is recommended to disable Password Manager and password breach notifications or use a dedicated automation profile to prevent browser prompts from interrupting the tests.

---

# Test Scenarios

Current automated test coverage includes:

- Valid Login
- Locked User Login
- Inventory Page Validation
- Add Item to Cart
- Remove Item from Cart
- Complete Checkout

---

# Author

**Joshua Carbon**

Computer Engineering Graduate

AI • Software Development • Test Automation • Embedded Systems