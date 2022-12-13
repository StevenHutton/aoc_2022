#import "Hash";using Basic :: #import "Basic";
#import "Windows";
#import "File";
#import "String";
#import "Math";

#load "../useful_stuff.jai";

point :: struct {
	x, y : int;
}

operator + :: (a: point, b: point) -> point {
    r: point = ---;
	
    r.x = a.x + b.x;
    r.y = a.y + b.y;
	
    return r;
}

operator - :: (a: point, b: point) -> point {
    r: point = ---;
	
    r.x = a.x - b.x;
    r.y = a.y - b.y;
	
    return r;
}

#poke_name Basic operator ==; 
operator == :: (a: point, b: point) -> bool {
	return a.x == b.x && a.y == b.y;
}


UP :: point.{0, 1};
DOWN :: point.{0, -1};
LEFT :: point.{-1, 0};
RIGHT :: point.{1, 0};

locations : [..]point;
points : [10]point;

move_points :: (direction: point, distance : int, head : point, tail: point) -> point, point {
	
	h := head;
	t := tail;
	for 0..distance-1 {
		h = h + direction;
		follow_point(*h, *t);
		array_add_if_unique(*locations, t);
	}
	
	return h, t;
}

move_points_2 :: (direction: point, distance : int, points : []point) {
	for 0..distance-1 {
		points[0] = points[0] + direction;
		for 0..points.count-2 {
			follow_point(*points[it], *points[it+1]);
		}
		array_add_if_unique(*locations, points[points.count-1]);
	}
}

follow_point :: (h : *point, t : *point) {
	//if we're far enough away
	if abs(h.x - t.x) > 1 || abs(h.y - t.y) > 1
	{
		dif:= <<h - <<t;
		if dif.x > 0 t.x += 1;
		else if dif.x < 0 t.x -= 1;
		if dif.y > 0 t.y += 1;
		else if dif.y < 0 t.y -= 1;
	}
}

puzzle_func :: ()
{
	print("Puzzle One : \n");
	H, T : point;
	
	lines := read_file_to_lines("input.txt");
	
	total_distance := 0;
	for lp : lines {
		distance := 0;
		if lp[0] == {
			case #char "R";
			distance = read_next_int(*lp);
			H, T = move_points(RIGHT, distance, H, T);
			case #char "L";
			distance = read_next_int(*lp);
			H, T = move_points(LEFT, distance, H, T);
			case #char "U";
			distance = read_next_int(*lp);
			H, T = move_points(UP, distance, H, T);
			case #char "D";
			distance = read_next_int(*lp);
			H, T = move_points(DOWN, distance, H, T);
		}
		total_distance += distance;
	}
	print("%\n", total_distance);
	print("%\n", locations.count);
	array_reset(*locations);
}

puzzle_func_2 :: ()
{
	print("Puzzle Two : \n");
	
	lines := read_file_to_lines("input.txt");
	
	total_distance := 0;
	for lp : lines {
		distance := 0;
		if lp[0] == {
			case #char "R";
			distance = read_next_int(*lp);
			move_points_2(RIGHT, distance, points);
			case #char "L";
			distance = read_next_int(*lp);
			move_points_2(LEFT, distance, points);
			case #char "U";
			distance = read_next_int(*lp);
			move_points_2(UP, distance, points);
			case #char "D";
			distance = read_next_int(*lp);
			move_points_2(DOWN, distance, points);
		}
		total_distance += distance;
	}
	print("%\n", total_distance);
	print("%\n", locations.count);
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