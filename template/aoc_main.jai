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
	content, success := read_entire_file("input.txt");
	lines := split(content, "\r\n");
	print("%\n", result);
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	content, success := read_entire_file("input.txt");
	lines := split(content, "\r\n");
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