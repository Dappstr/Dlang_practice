module source.app;

import std.stdio;
import std.conv; // to! conversions
import std.string;
import std.format; // formattedRead()
import std.file;
import std.bitmanip;
import std.traits; // EnumMembers template
import std.range; // stride()

//I will find a better way to do this in the future
union CPU_INST
{
	struct CPU
	{
		ushort PC; //Program counter
		ubyte SP, Acc, X, Y; //Registers: Stack Pointer, Accumulator, Index Register X, Index Register Y
	} CPU cpuObj;

	struct PS {
		mixin(bitfields!(
			ubyte, "C", 1, //Carry
			ubyte, "Z", 1, //Zero
			ubyte, "I", 1, //Interupt
			ubyte, "D", 1, //Decimal
			ubyte, "B", 1, //Break
			ubyte, "O", 1, //Overflow
			ubyte, "N", 1, //Negative
			bool, "flag", 1
		));
	} PS psObj;
}

void main()
{
    //readf("%s".chomp(), &someVar) <- .chomp() removes newline
	//Safe calculations: adds/addu, subs/subu, muls/mulu <- s = signed, u = unsigned
	//to!TYPE(object) for conversions in ternary operation
	//uniform(startingValue, outOfRangeValue) for random number generation

	/*
	writefln = formatted writeln
	%b: binary, %o = octal
	%x: hexadecimal, %d = decimal
	%s: literal value depending on type
	%,: separator (%,s = groups of 3, %,2s = groups of 2)
	%.Ng or %.Nf = precision of decimal places N

	readf format specifiers:
	%d: read an integer in the decimal system.
	%o: read an integer in the octal system.
	%x: read an integer in the hexadecimal system.
	%f: read a floating point number.
	%s: read according to the type of the variable. This is the most commonly used specifier.
	%c: read a single character. This specifier allows reading whitespace characters as well (they are not ignored anymore).
	*/

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

    //enum Suit { spades, hearts, diamonds, clubs }

	//EnumMembers template comes from std.traits, returns a static tuple of all members of the enumerated type arranged in declared order
   /* foreach (suit; EnumMembers!Suit) {
      writefln("%s: %d", suit, suit); 
    }
	Suit suit = cast(Suit)1; // Evaluates to hearts since "1" is casted to type Suit*/

	/*
	foreach(x, y; someContainer)
		for more than one name in the names section, x represents a counter, y represents the value
	when iterating over unicode, use the stride() function which considers the string as a container and takes two arguments:
		the specified string, and the amount of steps to take to stride over the characters.
	associative arrays contain .byKey, .byValue, and .byKeyValue traits to help with iterating and return efficient range objects
	
	.byKey is the only efficient way of iterating over just the keys of an associative array:
	int[string] aa = [ "blue" : 10, "green" : 20 ]; 
    foreach (key; aa.byKey) {
        writeln(key);
    }

	.byKeyValue provides access to each key-value element through a variable that is similar to a tuple. The key and the value are accessed separately through the .key and .value properties of that variable:
	int[string] aa = [ "blue" : 10, "green" : 20 ]; 
    foreach (element; aa.byKeyValue) { 
        writefln("The value for key %s is %s", element.key, element.value);
    }

	ref keyword creates a reference to the actual members or elements of the container.
	foreach(ref obj; container) {
		through obj, now everything iterated over container will take effect
		...
	}

	foreach_reverse() does the same as foreach but in reverse
	*/

	/*
	"goto case;" jumps to the next in line case
	"goto default" jumps to the default case
	The type of the switch expression is limited to integer types, string types and bool
	switch/case supports range syntax

	switch (someExpr) {
    case 1:
        ...

    case 2: .. case 5: 
        ...

    case 6:
        ...
	}

	The final switch statement works similarly to the regular switch statement, with the following differences:
		It cannot have a default section. Note that this section is meaningless when the case sections cover the entire range of values anyway, similar to the six values of the die above.
		Value ranges cannot be used with case sections (distinct values can be).
		If the expression is of an enum type, all values of the enum must be covered by the case statements.

	final switch (someExpr) {
		case 1:
		...

		case 2, 3, 4, 5: 
		...

		case 6:
		...
		}
	*/

	/*
	enum a = [ 42, 100 ]; 
	writeln(a);
	foo(a);

	is equivalent to

	writeln([ 42, 100 ]); an array is created at  run time 
	foo([ 42, 100 ]); another array is created at run time
	*/

	/*
	const erases the information about whether the original variable was mutable or immutable. This information is hidden even from the compiler
	immutable(T)[] slice = [...] equates to the elements being immutable rather than the slice its-self
	As a general rule, prefer immutable variables over mutable ones. For functions that take mutable data and have to modify it, immutable variables will not serve the purpose
	Specify variables as immutable if their values will never change but cannot be known at compile time
	Define constant values as enum if their values can be calculated at compile time
	*/
	
}
