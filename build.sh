#!/usr/bin/env bash
echo 'installing requirements'
pip install -r test-requirements.txt

echo 'setting up paths to development'
python setup.py develop

echo 'Pylint Code Review and Report Generation'
pylint --rcfile=pylint.rc  MIGDataCollector >  MIGDataCollector/pylint_unit.out

echo 'running nosetests with report generation and coverage options'

nosetests -s MIGDataCollector --with-coverage --cover-erase --cover-inclusive --cover-package=MIGDataCollector --cover-xml --with-xunit > nose_test.out
