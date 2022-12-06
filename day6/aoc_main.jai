#import "Basic";
#import "Windows";
#import "File";
#import "String";
#import "Hash";
#import "Hash_Table";

#load "../useful_stuff.jai";

find_non_repeating_squence :: (input : string, sequence_length : int) -> int
{
	output := -1;
	for i : 0..input.count-sequence_length {
		cursor1 := *input[i];
		while cursor1 < (*input[i] + sequence_length-1) 
		{
			cursor2 := cursor1 + 1;
			while cursor2 <= (*input[i] + sequence_length-1) {
				if <<cursor1 == <<cursor2 continue i;
				cursor2 += 1;
			}
			cursor1 += 1;
		}
		output = i+sequence_length;
		break;
	}
	return output;
}

puzzle_func :: ()
{
	print("Puzzle One : \n");
	content := read_entire_file("input.txt");
	output := find_non_repeating_squence(content, 4);
	print("%\n", output);
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	content := read_entire_file("input.txt");
	
	output :=  find_non_repeating_squence(content, 14);
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