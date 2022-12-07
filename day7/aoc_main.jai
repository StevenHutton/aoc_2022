#import "Basic";
#import "Windows";
#import "File";
#import "String";
#import "Hash";
#import "Hash_Table";

#load "../useful_stuff.jai";

answer1 := 0;

puzzle_func :: ()
{
	print("Puzzle One : \n");
	lines := read_file_to_lines("input.txt");
	print("%\n", answer1);
}

read_directory_from_lines :: (lines: []string, starting_index : int) -> int, int
{
	index := starting_index;
	test_line := lines[index];
	dir_size := 0;
	//check that first line is $ cd dir
	if !contains(test_line, "$ cd ") print("not a dir entry point\n");
	if contains(test_line, "$ cd ..") return starting_index, dir_size;
	
	//loop through all lines and add up file sizes
	while index < lines.count-1 {
		index+= 1;
		line := lines[index];
		if begins_with(line, "$ ls") continue;
		if begins_with(line, "dir") continue;
		if !begins_with(line, "$ cd ") 
		{
			continue; //recurse!
			
			index2, size := read_directory_from_lines(lines, index);
			index = index2;
			if size < 100000 { 
				dir_size += size;
				answer1 += size;
			}
		}
		if contains(line, "$ cd ..") return index, dir_size;
		value, success := parse_int(*line);
		if !success print("wtf?%\n", line);
		
		dir_size += value;
	}
	return index, dir_size;
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	lines := read_file_to_lines("input.txt");
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