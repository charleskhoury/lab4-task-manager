#!/bin/bash

echo "Running Task Manager..."

# Run todo.py — show output and save it for the HTML updater
python3 /app/.github/scripts/todo.py | tee /app/todo_output.txt

# Run the unit tests — show output and save it too
python3 /app/.github/scripts/todo-test.py | tee /app/test_output.txt

# Inject the task lists and test results into index.html
bash /app/.github/scripts/update_index.sh /app/todo_output.txt /app/test_output.txt

echo "Process Completed!"
