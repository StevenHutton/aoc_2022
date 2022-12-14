#import "PCG";
#import "Machine_X64";

timer_macro :: (code : Code) -> s64 #expand {
	begin_counter, end_counter, perf_frequency : s64;
	begin_cycle_count, end_cycle_count : u64;
	QueryPerformanceCounter(*begin_counter);
	QueryPerformanceFrequency(*perf_frequency);
	begin_cycle_count = rdtsc();
	
#insert code;
	
	QueryPerformanceCounter(*end_counter);
	end_cycle_count = rdtsc();
	elasped_cycles := end_cycle_count - begin_cycle_count;
	elapsed_time := (1000 * (end_counter - begin_counter)) / perf_frequency;
	
	print("Time : %ms, MegaCycles : %\n", elapsed_time, elasped_cycles / (1000*1000));
	return elapsed_time;
}

advance_to_digit :: (input : *string)
{
	index := find_index_of_any_from_left(<<input, "0123456789");
	advance(input, index-1);
}

read_next_int :: (input : *string) -> int, bool
{
	advance_to_digit(input); 
	value, success := parse_int(input);
	if !success print("Read int failed \n");
	
	return value, success;
}

read_file_to_lines :: (filename : string) -> [] string
{
	content := read_entire_file(filename);
	return split(content, "\r\n");
}