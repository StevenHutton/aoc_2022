#import "Basic";
#import "Windows";
#import "File";
#import "String";
#import "Hash";
#import "Hash_Table";

#load "../useful_stuff.jai";

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
	content, success := read_entire_file("input.txt");
	lines := split(content, "\r\n");
	
	count := 0;
	for line : lines {
		ranges := split(line, ",");
		vals1 := split(ranges[0], "-");
		vals2 := split(ranges[1], "-");
		
		low1 := parse_int(*vals1[0]);
		high1 := parse_int(*vals1[1]);
		low2 := parse_int(*vals2[0]);
		high2 := parse_int(*vals2[1]);
		
		if (low1 <= low2 && high1 >= high2) || (low2 <= low1 && high2 >= high1) count += 1;
	}
	
	print("%\n", count);
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	content, success := read_entire_file("input.txt");
	lines := split(content, "\r\n");
	
	count := 0;
	for line : lines {
		ranges := split(line, ",");
		vals1 := split(ranges[0], "-");
		vals2 := split(ranges[1], "-");
		
		low1 := parse_int(*vals1[0]);
		high1 := parse_int(*vals1[1]);
		low2 := parse_int(*vals2[0]);
		high2 := parse_int(*vals2[1]);
		
		if low1 <= high2 && high1 >= low2 count += 1;
	}
	
	print("%\n", count);
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