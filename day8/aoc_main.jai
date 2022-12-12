#import "Basic";
#import "Windows";
#import "File";
#import "String";
#import "Hash";
#import "Hash_Table";

#load "../useful_stuff.jai";

#insert #run get_input("input");

get_input :: (name : string) -> string
{
	builder : String_Builder;
	defer reset(*builder);
	
	lines := read_file_to_lines(tprint("%.txt", name));
	width := lines[0].count;
	print_to_builder(*builder, "width :: %;\n", width);
	print_to_builder(*builder, "height :: %;\n", lines.count);
	print_to_builder(*builder, "% := [%]int.[", name, width);
	for line : lines {
		print_to_builder(*builder, ".[");
		cursor : string;
		cursor.count = 1;
		cursor.data = line.data;
		for 0..line.count-1 
		{
			if it < line.count-1 print_to_builder(*builder, "%, ", cursor);
			else print_to_builder(*builder, "%", cursor);
			cursor.data += 1;
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
	for y: 0..height-1 {
		for x: 0..width-1 {
			visible_values[x][y] = false;
		}
	}
	
	//loop east
	for y: 0..height-1 {
		highest := -1;
		for x: 0..width-1 {
			if input[y][x] > highest {
				visible_values[y][x] = true;
				highest = input[y][x];
			}
		}
	}
	
	//view from west
	for y: 0..height-1 {
		highest := -1;
		for < x: width-1..0 {
			if input[y][x] > highest {
				visible_values[y][x] = true;
				highest = input[y][x];
			}
		}
	}
	
	//view from north
	for x: 0..width-1 {
		highest := -1;
		for y: 0..height-1 {
			if input[y][x] > highest {
				visible_values[y][x] = true;
				highest = input[y][x];
			}
		}
	}
	
	//view from south
	for x: 0..width-1 {
		highest := -1;
		for < y: height-1..0 {
			if input[y][x] > highest {
				visible_values[y][x] = true;
				highest = input[y][x];
			}
		}
	}
	
	count := 0;
	for y: 0..height-1 {
		for x: 0..width-1 {
			//print("%", ifx visible_values[y][x] 1 else 0);
			if visible_values[y][x] count += 1;
		}
		//print("\n");
	}
	print("%\n", count);
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	
	//loop through all values
	answer := 0;
	
	for y: 0..height-1 {
		for x: 0..width-1 {
			h := input[y][x];
			
			l, r, t, b := 0;
			
			//look top
			for < y-1..0 {
				t += 1;
				if input[it][x] >= h break;
			}
			//look bottom
			for y+1..height-1 {
				b += 1;
				if input[it][x] >= h break;
			}
			for < x-1..0 {
				l += 1;
				if input[y][it] >= h break;
			}
			for x+1..width-1 {
				r += 1;
				if input[y][it] >= h break;
			}
			
			ss := l * r * t * b;
			if ss > answer answer = ss;
		}
	}
	print("%\n", answer);
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