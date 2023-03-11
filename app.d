module source.app;

import std.stdio;
import std.conv; //to! conversions

void main() {
    //readf("%s".chomp(), &someVar) <- .chomp() removes newline
	//Safe calculations: adds/addu, subs/subu, muls/mulu <- s = signed, u = unsigned
	//to!TYPE(object) for conversions in ternary operation
	//uniform(startingValue, outOfRangeValue) for random number generation

	/*
	T[] arr; | Dynamically allocated
	arr.length = N; | Resized
	arr ~= n; | Append n to arr
				NOTE: Cannot append to fixed length arrays even if there is room
	arr.remove(indx); | Remove value at index from array
	arr.remove!(a => a == 42); | Lambda predicate function to remove any element that equals 42
				'a' is type deduced based on either the expression or underlying type of the array
	
	nt[10] first = 1;
    int[10] second = 2;
    int[] result;

    result = first ~ second; | result will have a size of 20 as it combines both first and second
	std.algorithm provides useful functions such as sort() and reverse()
	
	Associative arrays are implemented using a hash table.
	They map the values of one type to the values of another type. The values of the type that associative arrays map from are called keys rather than indexes. Associative arrays store their elements as key-value pairs
	An associative array that is defined without any element is null, not empty.

	

	int[string] days = ["monday": 0, "tuesday": 1, "test": 4];
	Value Type[Key Type]

	"in" operator searches for/determines if given key exists in associative array
	if("monday" in days) {
		...
	}

	.get() can be used for returning value if key does not exist in associative array
		.get(KEY, retValueIfNotFound)

	PROPERTIES:
		.length returns the number of key-value pairs.
		.keys returns a copy of all keys as a dynamic array.
		.byKey provides access to the keys without copying them; we will see how .byKey is used in foreach loops in a later chapter.
		.values returns a copy of all values as a dynamic array.
		.byValue provides access to the values without copying them.
		.byKeyValue provides access to the key-value pairs without copying them.
		.rehash may make the lookups in an array more efficient in some cases, such as after inserting a large number of key-value pairs.
		.sizeof is the size of the array reference (it has nothing to do with the number of key-value pairs in the table and is the same value for all associative arrays).
		.get returns the value if it exists, or the default value otherwise.
		.remove removes the specified key and its value from the array.
		.clear removes all elements.

	*/
}
