#import "Basic";
#import "Windows";
#import "File";
#import "String";
#import "Hash";
#import "Hash_Table";

#load "../useful_stuff.jai";

point :: struct {
	x, y : int;
}

puzzle_func :: ()
{
	print("Puzzle One : \n");
	H, T : point;
	
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
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