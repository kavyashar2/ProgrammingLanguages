fun filter f nil = nil
  | filter f (x::xs) = if f x then x :: filter f xs else filter f xs;

fun quicksort nil = nil
  | quicksort (x::xs) =
	let
	    fun above y = y >= x
	    fun below y = y < x
	in
	    quicksort (filter below xs) @
            x :: quicksort (filter above xs)
	end;

	fun quicksort cmp [] = []
  | quicksort cmp (pivot::rest) =
      let
        val less = List.filter (fn x => cmp(x, pivot) = LESS) rest
        val equal = List.filter (fn x => cmp(x, pivot) = EQUAL) rest
        val greater = List.filter (fn x => cmp(x, pivot) = GREATER) rest
      in
        quicksort cmp less @ (pivot :: equal) @ quicksort cmp greater
      end