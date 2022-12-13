#import "Basic";
#import "Windows";
#import "File";
#import "String";
#import "Hash";
#import "Hash_Table";

#load "../useful_stuff.jai";


global_counter := 0;
global_register := 1;
global_signal_strength := 0;

increment_counter :: ()
{
	current_pixel := global_counter % 40 ;
	if global_register == current_pixel || global_register-1 == current_pixel || global_register+1 == current_pixel
		print("#"); else print(".");
	
	global_counter += 1;
	if global_counter == 40 || 
		global_counter == 80 || 
		global_counter == 120 || 
		global_counter == 160 || 
		global_counter == 200 || 
		global_counter == 240 {
		print("\n");
	}
	
	if global_counter == 20 || 
		global_counter == 60 || 
		global_counter == 100 || 
		global_counter == 140 || 
		global_counter == 180 || 
		global_counter == 220 {
		global_signal_strength += global_register * global_counter;
	}
	
	
	
}

puzzle_func :: ()
{
	print("Puzzle One : \n");
	lines := read_file_to_lines("input.txt");
	
	for lines {
		if begins_with(it, "noop") increment_counter();
		if begins_with(it, "addx") {
			value := read_next_int(*it);
			increment_counter();
			increment_counter();
			global_register += value;
		}
	}
	print("%\n", global_signal_strength);
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