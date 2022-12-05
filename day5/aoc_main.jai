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
	
	stacks : [9][..]u8;
	place := 0;
	for line : lines {
		cursor := 0;
		while (cursor*4) < line.count {
			char := line[(cursor*4)+1];
			if char >= 65 && char <= 90 array_insert_at(*stacks[cursor], char, 0);
			cursor += 1;
		}
		
		if equal(line, "")
		{
			place = it_index+1;
			break;
		}
	}
	
	for place..lines.count-1 {
		line : string = lines[it];
		tomove, source, destination : int;
		
		tomove = read_next_int(*line);
		source = read_next_int(*line);
		destination = read_next_int(*line);
		
		source -= 1;
		destination -= 1;
		
		for 0..tomove-1 {
			array_add(*stacks[destination], pop(*stacks[source]));
		}
	}
	
	output : [9]u8;
	for stack : stacks {
		output[it_index] = peek(stack);
	}
	print("%\n", cast(string)output);
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	lines := read_file_to_lines("input.txt");
	
	stacks : [9][..]u8;
	place := 0;
	for line : lines {
		cursor := 0;
		while (cursor*4) < line.count {
			char := line[(cursor*4)+1];
			if char >= 65 && char <= 90 array_insert_at(*stacks[cursor], char, 0);
			cursor += 1;
		}
		
		if equal(line, "")
		{
			place = it_index+1;
			break;
		}
	}
	
	for place..lines.count-1 {
		line := lines[it];
		tomove, source, destination : int;
		success : bool;
		tomove = read_next_int(*line);
		source = read_next_int(*line);
		destination = read_next_int(*line);
		source -= 1;
		destination -= 1;
		
		stack : []u8 = stacks[source];
		stack.data += (stack.count)-tomove;
		stack.count = tomove;
		stacks[source].count -= tomove;
		array_add(*stacks[destination], ..stack);
	}
	
	output : [9]u8;
	for stack : stacks {
		output[it_index] = peek(stack);
	}
	print("%\n", cast(string)output);
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