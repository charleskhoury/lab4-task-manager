#!/bin/bash

# Inputs: $1 = task output file, $2 = test results file
TASK_FILE=$1
TEST_FILE=$2

# Extract the ToDo and Done sections from the task output
TODO_TASKS=$(awk '/ToDo Tasks:/{flag=1;next} /Done Tasks:/{flag=0} flag' "$TASK_FILE")
DONE_TASKS=$(awk '/Done Tasks:/{flag=1;next} flag' "$TASK_FILE")
TEST_RESULTS=$(cat "$TEST_FILE")

# Replace the content inside a given <pre id="..."> block in index.html
update_pre() {
    local id="$1"
    local content="$2"
    local file="$3"
    CONTENT="$content" perl -0777 -i -pe '
        my $c = $ENV{"CONTENT"};
        s{(<pre id="'"$id"'">).*?(</pre>)}{$1\n$c\n$2}s;
    ' "$file"
}

update_pre "todo-tasks" "$TODO_TASKS" index.html
update_pre "done-tasks" "$DONE_TASKS" index.html
update_pre "test-results" "$TEST_RESULTS" index.html

echo "index.html updated."
