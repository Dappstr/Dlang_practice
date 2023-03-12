module source.app;

import std.stdio;
import std.conv;
import std.string; //to! conversions
import std.format; //formattedRead()
import std.file;
import std.bitmanip;

//Playing with bitfields
struct CPU
{
	ushort PC; //Program counter
	ubyte SP, Acc, X, Y; //Registers: Stack Pointer, Accumulator, Index Register X, Index Register Y

	//Processor Status Flags
	struct PS {
		mixin(bitfields!(
			ubyte, "C", 1,
			ubyte, "Z", 1,
			ubyte, "I", 1,
			ubyte, "D", 1,
			ubyte, "B", 1,
			ubyte, "O", 1,
			ubyte, "N", 1,
			bool, "flag", 1
		));
	}
}

void main()
{

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
	
	int[10] first = 1;
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

	PROPERTIES of associative arrays:
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

	Number range syntax: n_1 .. n_2 <- n1_ through but not including n_2, n_1 must also be less than n_2
	A slice (dynamic array that is created from a number range) has its elements linked to the original array and do not have their own actual values
	"$" represents the length of the array
	.dup property creates a duplicate allowing a dynamic array to copy from another static array without linking/binding elements
	When a slice has another value added exceeding its original capacity, value sharing with the original array is ceased
	Shortening a slice does not affect sharing
	.capacity property returns a 0 if a slice cannot store any more values, and number N for amount of values it can store
	When the number of elements to append is known beforehand, it is possible to reserve capacity for the elements using the .reserve function
	*/

	/*
	char <- UTF-8 , initial value: 0xFF
	wchar <- UTF-16 , initial value: 0xFFFF
	dchar <- UTF-32 , initial value: 0x000FFFFF
	Short names for (named) characters are denoted through \&
		wchar currencySymbol = '\&euro;';
		https://dlang.org/spec/entity.html
	
	std.uni module includes functions for working with unicode characters:
		isLower: is it a lowercase character?
		isUpper: is it an uppercase character?
		isAlpha: is it a Unicode alphabetic character?
		isWhite: is it a whitespace character?

		The functions that start with “to” produce new characters from existing ones:
		toLower: produces the lowercase version of the given character.
		toUpper: produces the uppercase version of the given character.
	*/

	/*
	readln(name);
	name = strip(name);
	readln reads up until the end of the line
	strip() removes trailing and leading whitespace, and can be chained
		string name = strip(readln());
	
	formattedRead() from std.format converts separate data.
		first argument = line to read from
		second parameter are amount to divide in
		...n parameters are objects to read into
	string line = strip(readln());
    string name;
    int age;
    formattedRead(line, " %s %s", name, age);
	amount of "data items" can be validated as such:
		uint items = formattedRead(line, " %s %s", name, age); 
		if (items != 2) {
  			writeln("Error: Expected more than one item.");
		}
	string is immutable
	char[] is mutable
	.dup for duplicating a string to a mutable char array
	.idup for duplicating a mutable char array to an immutable string
	.icmp for comparing strings

	dchar[] s = "résumé"d.dup;
	There is a d at the end of the literal "résumé"d, specifying its type as an array of dchars
	'~' concatenates two strings, '~=' appends to string
	*/

	/*
	./app < src.txt streams input from src.txt into the app
	./app > dst.txt streams output from app into src.txt
	std.stdio module has a File struct
	Byte Order Mark (BOM) may be required on some systems, which specifies the order the UTF code unites of characters are arranged
	The std.file module contains functions and types that are useful when working with the contents of directories
	if (exists(fileName)) {
    	there is a file or directory under that name
  }
	*/

	/*	
	Access modes:
	r = read
	r+ = read/write, will error if file does not exist
	w = write access, if file does not exist, it is created, IF FILE DOES EXIST, ITS CONTENTS ARE CLEARED
	w+ = write/read, if file does not exist, it is created, IF FILE DOES EXIST, ITS CONTENTS ARE CLEARED
	a = append, if file does not exist, it is created, once opened, it is written only towards the end
	a+ = read and append, if file does not exist, it is created, once opened, it is written only towards the end

	.readln property for reading from file object
	.writeln property for writing to file object
	
	File file = File("test.txt", "w+");
	if(exists("test.txt")) {
		/*
		Entire block is useless since file has been cleared due to access mode
		while(!file.eof()) {
			string line = strip(file.readln());
			writeln(line);
		}
		
		file.writeln("Test ", "Four");
	}
	file.close();
	*/
}
