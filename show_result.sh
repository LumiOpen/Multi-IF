
file1="./results/${1}_test_long_sys/eval_result_step_1_metric.csv"
file2="./results/${1}_test_long_sys/eval_result_step_2_metric.csv"
file3="./results/${1}_test_long_sys/eval_result_step_3_metric.csv"
awk 'FNR==3 { sum += $1; count++ } END { if (count > 0) printf "Multi-IF overall average: %.2f\n", (sum / count)*100 }' $file1 $file2 $file3
awk 'FNR==6 { sum += $1; count++ } END { if (count > 0) printf "Multi-IF English average: %.2f\n", (sum / count)*100 }' $file1 $file2 $file3
