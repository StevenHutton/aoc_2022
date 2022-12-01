#import "Basic";
#import "Windows";
#import "PCG";
#import "Machine_X64";
#import "File";
#import "String";

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

puzzle_func :: ()
{
	print("Puzzle One : \n");
	content, success := read_entire_file("input1.txt");
	lines := split(content, "\n");
	count, highest : int = 0;
	
	for line : lines 
	{
		if line.count == 1 {
			if count > highest highest = count;
			count = 0;
		}
		else count += parse_int(*line);
	}
	
	print("%\n", highest);
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	content, success := read_entire_file("input1.txt");
	lines := split(content, "\n");
	count, first, second, third : int = 0;
	
	for line : lines 
	{
		if line.count == 1
		{
			if count > third
			{
				third = count;
				if third > second second, third = swap(second, third);
				if second > first first, second = swap(first, second);
			}
			count = 0;
		}
		else count += parse_int(*line);
	}
	print("% + % + %\n", first, second, third);
	print("%\n", first + second + third);
}

main :: ()
{
	temp_context := context;
	temp_context.allocator = temp;
	
	push_context temp_context {							
		timer_macro(puzzle_func());
		timer_macro(puzzle_func_2());
	}
	reset_temporary_storage();
}