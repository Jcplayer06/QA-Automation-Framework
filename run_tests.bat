@echo off
echo =====================================
echo Running Robot Framework Tests...
echo =====================================

robot --outputdir reports tests

echo.
echo =====================================
echo Running AI-Assisted Test Analysis...
echo =====================================

python libraries\ai_helper.py

pause
