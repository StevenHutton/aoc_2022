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

convert_value :: (value : u8) -> u8
{
	if value >= 97 value -= 96;
	else {
		value -= 38;
	}
	return value;
}

puzzle_func :: ()
{
	print("Puzzle One : \n");
	content, success := read_entire_file("input3.txt");
	lines := split(content, "\r\n");
	
	result : int = 0;
	for line : lines {
		part1 := line;
		part1.count = line.count/2;
		part2 := line;
		part2.count = line.count/2;
		part2.data += line.count/2;
		
		index := find_index_of_any_from_left(part2, part1);
		result += convert_value(part2[index]);;
	}
	print("%\n", result);
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	content, success := read_entire_file("input3.txt");
	lines := split(content, "\r\n");
	
	result : int = 0;
	iterator := 0;
	while iterator < lines.count
	{
		for 0..lines[iterator].count-1 {
			index := find_index_from_left(lines[iterator+1], lines[iterator][it]);
			if index == -1 continue;
			
			index2 := find_index_from_left(lines[iterator+2], lines[iterator][it]);
			if index2 != -1 {
				result += convert_value(lines[iterator][it]);
				break;
			}
		}
		
		iterator += 3;
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