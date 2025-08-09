#!/bin/zsh

# We use this array to keep track of backgrounded script_set PIDs
job_sets=()
for script_dir_name in "$@"; do
 (
    mkdir -p "$(dirname "$0")/logs"
    export INCOMPLETE_JOB_LOG="$(dirname "$0")/logs/incomplete_jobs.log"

    # We use this array to keep track of backgrounded script PIDs
    script_jobs=()
    script_dir="$(dirname "$0")/$script_dir_name"

    wait_for_jobs() {
      failed=0
      for job in $script_jobs; do
        wait $job || let "failed+=1"
      done

      script_jobs=()
      if [ "$failed" != "0" ]; then
        exit 1
      fi
    }

    for script in $script_dir/*.sh; do 
      script_name=$(basename "$script")
      last_script_number=${script_number}
      script_number=${script_name:0:2}

      # Once we're into a new number-set (e.g. 01 -> 02) or more than 3 jobs, wait for jobs to finish
      if [ "$script_number" != "$last_script_number" ] || (( ${#script_jobs[@]} > 3 )); then
        wait_for_jobs
      fi

      # Runs the script by its path, and uses sed to prepend the name to its stdout
      (
        echo "$script_dir_name/$script_name" >> "$INCOMPLETE_JOB_LOG"
        $(dirname $0)/run_script.sh "$script" |& sed -e "s/^/[${script_name:3:-3}] /"
        sed -i '' "/$script_dir_name\/$script_name/d" "$INCOMPLETE_JOB_LOG"
        return ${pipestatus[1]}
      ) & script_jobs+="$!"
    done

    wait_for_jobs
 ) & job_sets+="$!"
done

failed_sets=0
for job_set in $job_sets; do
  wait $job_set || let "failed_sets+=1"
done

exit $failed_sets
