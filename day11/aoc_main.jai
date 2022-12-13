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
	lines := read_file_to_lines("input.txt");
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
		timer_macro(puzzle_func());
		timer_macro(puzzle_func_2());
	}
	reset_temporary_storage();
}