#import "Basic";
#import "Windows";
#import "File";
#import "String";
#import "Hash";
#import "Hash_Table";

#load "../useful_stuff.jai";

#insert #run get_input();

get_input :: () -> string
{
	builder : String_Builder;
	defer reset(*builder);
	
	lines := read_file_to_lines("input.txt");
	width := lines[0].count;
	print_to_builder(*builder, "width :: %;\n", width);
	print_to_builder(*builder, "height :: %;\n", lines.count);
	print_to_builder(*builder, "grid := [%]int.[", width);
	for line : lines {
		print_to_builder(*builder, ".[");
		for 0..line.count-1 
		{
			if it < line.count-1 print_to_builder(*builder, "%, ", line[it]);
			else print_to_builder(*builder, "%", line[it]);
		}
		if it_index < lines.count-1 print_to_builder(*builder, "],\n");
		else print_to_builder(*builder, "]");
	}
	
	print_to_builder(*builder, "];");
	return builder_to_string(*builder);
}

puzzle_func :: ()
{
	print("Puzzle One : \n");
	
	visible_values : [width][height]bool;
	
	//loop east
	for y: 0..height-1 {
		for x: 0..width-1 {
			highest := 0;
			if grid[y][x] > highest {
				visible_values[y][x] = true;
				highest = grid[y][x];
			}
		}
	}
	
	//view from west
	for y: 0..height-1 {
		for < x: width-1..0 {
			highest := 0;
			if grid[y][x] > highest {
				visible_values[y][x] = true;
				highest = grid[y][x];
			}
		}
	}
	
	//view from north
	for y: 0..height-1 {
		for < x: width-1..0 {
			highest := 0;
			if grid[y][x] > highest {
				visible_values[y][x] = true;
				highest = grid[y][x];
			}
		}
	}
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