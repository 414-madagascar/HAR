%input a sample video histogram 
sample_data ='./OF_his_Result/FootBall_p5&p6';
result_list = [];

%histogram data analyzing 
sum_data = calculate_sum(sample_data);
if sum_data < 200000000
    disp("Boxing")
    return 
end
if sum_data > 770000000
    disp("Volleyball")
    return 
end

%Histogram distance subtraction
%result_FootBall = calculate_difference(sample_data,'./OF_his_test_Result/Boxing_70');
%result_list = [result_list,result_FootBall];
result_FootBall = calculate_difference(sample_data,'./OF_his_test_Result/FootBall_70');
result_list = [result_list,result_FootBall];
result_TableTennis = calculate_difference(sample_data,'./OF_his_test_Result/TableTennis_70');
result_list = [result_list,result_TableTennis];
%result_FootBall = calculate_difference(sample_data,'./OF_his_test_Result/Volleyball_70');
%result_list = [result_list,result_FootBall];

%Pick the smallest result as the most samilar action
[stuff, result_number] = min(result_list);
if result_number == 1
   disp("FootBall") 
elseif result_number ==2
   disp("TableTennis") 
end




