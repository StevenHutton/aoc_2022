#import "Basic";
#import "Windows";
#import "PCG";
#import "Machine_X64";
#import "File";
#import "String";
#import "Hash";
#import "Hash_Table";

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
	val := "steven\nbarry\nhutton\nthe\nthi rd\n";
	
	print("Puzzle One : \n");
	content, success := read_entire_file("input2.c");
	lines := split(content, "\r\n");
	
	hash_table : Table(string, int);
	init(*hash_table);
	
	//rick vs 
	table_add(*hash_table, "A X", 4);//rock
	table_add(*hash_table, "A Y", 8);//paper
	table_add(*hash_table, "A Z", 3);//scissors
	//paper vs
	table_add(*hash_table, "B X", 1);
	table_add(*hash_table, "B Y", 5);
	table_add(*hash_table, "B Z", 9);
	//scis vs
	table_add(*hash_table, "C X", 7);
	table_add(*hash_table, "C Y", 2);
	table_add(*hash_table, "C Z", 6);
	
	result : int = 0;
	for line : lines {
		value, success := table_find(*hash_table, line);
		if !success print("% %\n", line, it_index);
		
		result += value;
	}
	
	print("%\n", result);
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	content, success := read_entire_file("input2.c");
	lines := split(content, "\r\n");
	
	hash_table : Table(string, int);
	init(*hash_table);
	
	//rock vs 
	table_add(*hash_table, "A X", 3);//lose
	table_add(*hash_table, "A Y", 4);//draw
	table_add(*hash_table, "A Z", 8);//win
	//paper vs
	table_add(*hash_table, "B X", 0 + 1);
	table_add(*hash_table, "B Y", 3 + 2);
	table_add(*hash_table, "B Z", 6 + 3);
	//scis vs
	table_add(*hash_table, "C X", 0 + 2);
	table_add(*hash_table, "C Y", 3 + 3);
	table_add(*hash_table, "C Z", 6 + 1);
	
	result : int = 0;
	for line : lines {
		value, success := table_find(*hash_table, line);
		if !success print("% %\n", line, it_index);
		
		result += value;
	}
	
	print("%\n", result);
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