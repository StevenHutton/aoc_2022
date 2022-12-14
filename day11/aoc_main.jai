#import "Basic";
#import "Windows";
#import "File";
#import "String";
#import "Hash";
#import "Hash_Table";

#load "../useful_stuff.jai";

monkey :: struct() {
	items : [..]u64;
	func : (u64) -> u64;
	divisor : u64;
	positive_index : int;
	negative_index : int;
	inspected_count : int = 0;
}

create_monkey :: (i : []u64, f : (u64) -> u64, d : u64, p : int, n : int) -> monkey
{
	result : monkey;
	using result;
	
	array_add(*items, ..i);
	func = f;
	divisor = d;
	positive_index = p;
	negative_index = n;
	
	return result;
}

parse_input :: () -> string
{
	builder : String_Builder;
	defer reset(*builder);
	
	lines := read_file_to_lines("input.txt");
	monkey_index := 0;
	
	for 0..lines.count-1 {
		if begins_with(lines[it], "Monkey") {
			items := lines[it+1];
			op := lines[it+2];
			div := lines[it+3];
			pos := lines[it+4];
			neg := lines[it+5];
			
			advance(*items, "  Starting items: ".count);
			advance(*op, "  Operation: ".count);
			advance(*div, "  Test: divisible by ".count);
			advance(*pos, "    If true: throw to monkey ".count);
			advance(*neg, "    If false: throw to monkey ".count);
			
			format_string:: #string DONE
				monkies[%] = create_monkey(u64.[%], (old : u64) -> u64 {
											   new : u64;
											   %; 
											   return new;
										   }, %, %, %);
			
			DONE
				
				print_to_builder(*builder, format_string, monkey_index, items, op, div, pos, neg);
			monkey_index += 1;
		}
	}
	
	return builder_to_string(*builder);
}

puzzle_func :: ()
{
	print("Puzzle One : \n");
	
	monkies : [8]monkey;
#insert #run parse_input();
	
	for i : 1..20 {
		for *monkey : monkies {
			while monkey.items.count > 0
			{
				//print("Loop : %, Monkey : %, items left : %\n", i, it_index, monkey.items.count);
				item := monkey.items[0];
				new := monkey.func(item);
				monkey.items[0] = new/3;
				if monkey.items[0] % monkey.divisor == 0 {
					array_add(*monkies[monkey.positive_index].items, monkey.items[0]);
					array_ordered_remove_by_index(*monkey.items, 0);
				} else {
					array_add(*monkies[monkey.negative_index].items, monkey.items[0]);
					array_ordered_remove_by_index(*monkey.items, 0);
				}
				monkey.inspected_count += 1;
			}
		}
	}
	for monkies {
		print("Monkey% : Count : %\n", it_index, it.inspected_count);
	}
}

accum :: (array : []$T, func : (x : T, y : u64) -> u64) -> u64
{
	out : u64 = 1;
	for item : array {
		out = func(item, out);
	}
	return out;
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	
	monkies : [8]monkey;
#insert #run parse_input();
	
	prod_of_divsors := accum(monkies, (monkey, y) => monkey.divisor * y );
	print("%\n", prod_of_divsors);
	
	for i : 1..10000 {
		for *monkey : monkies {
			while monkey.items.count > 0
			{
				//print("Loop : %, Monkey : %, items left : %\n", i, it_index, monkey.items.count);
				item := monkey.items[0];
				new := monkey.func(item);
				monkey.items[0] = new % prod_of_divsors;
				if monkey.items[0] % monkey.divisor == 0 {
					array_add(*monkies[monkey.positive_index].items, monkey.items[0]);
					array_ordered_remove_by_index(*monkey.items, 0);
				} else {
					array_add(*monkies[monkey.negative_index].items, monkey.items[0]);
					array_ordered_remove_by_index(*monkey.items, 0);
				}
				monkey.inspected_count += 1;
			}
		}
	}
	for monkies {
		print("Monkey% : Count : %\n", it_index, it.inspected_count);
	}
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