#import "Basic";
#import "Windows";
#import "File";
#import "String";
#import "Hash";
#import "Hash_Table";

#load "../useful_stuff.jai";

puzzle_func :: ()
{
	print("Puzzle One : \n");
	content := read_entire_file("input.txt");
	
	output := -1;
	print("%\n", content.count);
	for i: 0..content.count-3 {
		for < j : 3..1 {
			sub_str := slice(content, i+(4-j), j);
			k := i+(3-j);
			if contains(sub_str, content[k]) continue i;
		}
		output = i+4;
		break;
	}
	print("%\n", output);
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	content := read_entire_file("input.txt");
	
	output := -1;
	for i: 0..content.count-13 {
		for < j : 13..1 {
			sub_str := slice(content, i+(14-j), j);
			k := i+(13-j);
			if contains(sub_str, content[k]) continue i;
		}
		output = i+14;
		break;
	}
	print("%\n", output);
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