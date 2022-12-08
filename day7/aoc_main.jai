#import "Basic";
#import "Windows";
#import "File";
#import "String";
#import "Hash";
#import "Hash_Table";

#load "../useful_stuff.jai";

answer1 := 0;

test_func :: ()
{
	print("Test : \n");
	lines := read_file_to_lines("test.txt");
	index, size := read_directory_from_lines(lines, 0);
	if size <= 100000 {
		answer1 += size;
	}
	print("%\n", answer1);
}

puzzle_func :: ()
{
	answer1 = 0;
	print("Puzzle One : \n");
	lines := read_file_to_lines("input.txt");
	index, size := read_directory_from_lines(lines, 0);
	if size <= 100000 {
		answer1 += size;
	}
	print("%\n", answer1);
}

read_directory_from_lines :: (lines: []string, starting_index : int) -> int, int
{
	index := starting_index;
	test_line := lines[index];
	dir_size := 0;
	//check that first line is $ cd dir
	if !contains(test_line, "$ cd ") print("not a dir entry point\n");
	
	//loop through all lines and add up file sizes
	while index < lines.count-1 {
		index += 1;
		line := lines[index];
		if begins_with(line, "$ ls") continue;
		if begins_with(line, "dir") continue;
		if begins_with(line, "$ cd ..") return index, dir_size;
		if begins_with(line, "$ cd ")
		{
			index2, size := read_directory_from_lines(lines, index);
			index = index2;
			dir_size += size;
			if size <= 100000 { 
				answer1 += size;
			}
			continue;
		}
		value, success := parse_int(*line);
		if !success print("failed to read int %\n", line);
		dir_size += value;
	}
	return index, dir_size;
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	lines := read_file_to_lines("input.txt");
	
}

main :: ()
{
	temp_context := context;
	temp_context.allocator = temp;
	
	push_context temp_context {
		timer_macro(test_func());
		timer_macro(puzzle_func());
		timer_macro(puzzle_func_2());
	}
	reset_temporary_storage();
}