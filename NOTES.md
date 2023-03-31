	MISC
	
	`readf("%s".chomp(), &someVar)` <- `.chomp()` removes newline
	Safe calculations: adds/addu, subs/subu, muls/mulu <- s = signed, u = unsigned
	`uniform(startingValue, outOfRangeValue)` for random number generation
	

	FORMAT SPECIFIERS
	
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
	

	ARRAYS
	
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
	

	CHARACTERS
	
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


	STRINGS
	
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
	

	INPUT/OUTPUT TO BINARY
	
	./app < src.txt streams input from src.txt into the app
	./app > dst.txt streams output from app into src.txt
	std.stdio module has a File struct
	Byte Order Mark (BOM) may be required on some systems, which specifies the order the UTF code unites of characters are arranged
	The std.file module contains functions and types that are useful when working with the contents of directories
	if (exists(fileName)) {
    	there is a file or directory under that name
	}
	

	FILES
		
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
	

	//---ENUMS---\\
	
	EnumMembers template comes from std.traits, returns a static tuple of all members of the enumerated type arranged in declared order
	enum Suit { spades, hearts, diamonds, clubs }
   	foreach (suit; EnumMembers!Suit) {
      writefln("%s: %d", suit, suit); 
    }
	Suit suit = cast(Suit)1; // Evaluates to hearts since "1" is casted to type Suit
	enum a = [ 42, 100 ]; 
	writeln(a);
	foo(a);
	is equivalent to
	writeln([ 42, 100 ]); an array is created at  run time 
	foo([ 42, 100 ]); another array is created at run time
	

	FOREACH & ASSOCIATIVE ARRAYS
	
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
	

	SWITCH BLOCKS
	
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


	CONST AND IMMUTABLE
	
	const erases the information about whether the original variable was mutable or immutable. This information is hidden even from the compiler
	immutable(T)[] slice = [...] equates to the elements being immutable rather than the slice its-self
	As a general rule, prefer immutable variables over mutable ones. For functions that take mutable data and have to modify it, immutable variables will not serve the purpose
	Specify variables as immutable if their values will never change but cannot be known at compile time
	Define constant values as enum if their values can be calculated at compile time
	

	FUNCTION PARAMETER SPECIFIERS
	
	"ref" parameters are an alias to an object and are not guaranteed to modify it
	"auto ref" is used in templates only. It specifies that if the argument is an lvalue, then a reference to it is passed; if the argument is an rvalue, then it is passed by copy.
	"out" parameters are also an alias to an object and are guaranteed to modify it as the objects value is not considered
	"in" preserves the argument
	"const" declares that objects will not be modified
	"immutable" declares only non-changeable objects can be passed
	"inout" carries the mutability of the parameter on to the return type. If the parameter is const, immutable or mutable; then the return value is also const, immutable or mutable; respectively
	
	Evaluating arguments before calling a function is called eager evaluation.
	The "lazy" keyword specifies that an expression that is passed as a parameter will be evaluated only if and when needed.
		NOTE: lazy parameter is evaluated every time that parameter is used in the function
	The "scope" keyword specifies that a parameter will not be used beyond the scope of the function. Currently the scope is effective only if the function is defined as @safe and if the -dip1000 compiler switch is used.
	The "shared" keyword requires that the parameter is shareable between threads of execution
	The "return" keyword can be applied to a parameter to prevent such bugs. It specifies that a parameter must be a reference to a variable with a longer lifetime than the returned reference
		A sealed reference is when you have a reference to an object that extend beyond its lifetime
	

	MAIN
	
	if main is declared with a void return type, the return value is nonzero if an exception is thrown
	stderr is the stream used for writing error messages
	

	PROGRAM ARGUMENTS
	
	std.getopt module helps in parsing command line arguments for your program
	The getopt() function parses and assigns those values to variables. As we saw with readf(), the addresses of variables must be specified by the & operator
	void main(string[] args) {
		int count, minimum, maximum;
		
		getopt(args,
			"count", &count,
			"minimum", &minimum, 
			"maximum", &maximum);
		foreach (i; 0 .. count) {
			write(uniform(minimum, maximum + 1), ' '); 
		}
		writeln(); 
	}
	example:
	./app --count=7 --minimum=10 --maximum=15
	

	PROGRAM ENVIRONMENT
	
	std.process allows access to environment your binary sits in
	writeln(environment["PATH"]); prints the path of your binary
	executeShell() can access and execute other programs
	

	EXCEPTIONS
	
	Only the types that are inherited from the Throwable class can be thrown.
	The types that are actually thrown are types that are inherited from Exception or Error, which themselves are the types that are inherited from Throwable.
	Error represents unrecoverable conditions and is not recommended to be caught
	In most cases, instead of creating an exception object explicitly by new and throwing it explicitly by throw, the enforce() function is called
		example:
		enforce(count >= 0, format("Invalid dice count: %s", count));
	Use throw in situations when it is not possible to continue
	try {
    // the code block that is being executed, where an exception may be thrown
	} catch (an_exception_type) {
		// expressions to execute if an exception of this type is caught
	} finally {
		// expressions to execute regardless of whether an exception is thrown
	}
	if opening a file fails for example, a "std.exception.ErrnoException" exception object will be thrown
											std.exception.ConvException is for conversion errors
	objects of type Error can also be caught, although NOT RECOMMENDED
	catch(Exception exc) is a general "catch-all" for exceptions and is not recommended
	the "finally" block will execute regardless of if an exception is thrown or not
	PROPERTIES OF EXCEPTION OBJECTS:
		.file: the source file where the exception was thrown from
		.line: the line number where the exception was thrown from
		.msg:  the error message
		.info: the state of the program stack when the exception was thrown
		.next: the next collateral exception
	 Exceptions that are thrown while leaving scopes due to an already thrown exception are called collateral exceptions.
	 Both the main exception and the collateral exceptions are elements of a linked list data structure, where every exception object is accessible through the .next property of the previous exception object
	scope expressions are executed depending on how a scope exits
		scope(exit): the expression is always executed when exiting the scope, regardless of whether it is successful or due to an exception
		scope(success): the expression is executed only if the scope is being exited successfully
		scope(failure): the expression is executed only if the scope is being exited due to an exception
	scope(exit) writeln("scope exited normally");
	scope(success) {
		writeln("scope exited successfully");
		...
	}
	scope(failure) writeln("scope exited with a failure);
	when no exception is thrown, scope(exit) and scope(success) are executed, when an exception is thrown, scope(exit) and scope(failure) are executed
	

	ASSERT AND ENFORCE
	
	assert() performs run-time checks
	static assert() performs compile-time checks
	compiler flag -release ignores asserts
	enforce() is a wrapper for assert() that throws exceptions
	if (count < 3) { throw new Exception("Must be at least 3."); } -> Equivalent: enforce(count >= 3, "Must be at least 3.");
	

	UNIT TESTING
	
	unittest blocks are for unit testing and do not affect the program directly
	std.exception module contains two functions that help with testing for exceptions:
		assertThrown: ensures that a specific exception type is thrown from an expression
		assertNotThrown: ensures that a specific exception type is not thrown from an expression
	

	CONTRACT PROGRAMMING
	
	contract programming in D is enabled by default (disabled with the -release flag) and implemented in 3 types of code blocks:
		in, out, and struct/class invariant blocks
	in an "in" or "out" block, checks are performed (such as asserts) or what're called "preconditions" for "in" respectively, and "postconditions" for "out" respectively.
	"in" and "out" blocks must be followed by "do" blocks
	void someFunc(...) {
		in {
			assert(...);
			assert(...);
		} do {
			...
		}
	}
	void someOtherFunc(...) {
		out (someVar) {
			assert(someVar...);
		} do {
			...
		}
	}
	Other example with cleaner code:
	int func(int a, int b) {
		in (a >= 7, "a cannot be less than 7") in (b < 10)
		out (result; result > 1000) {
			...
		}
	}
	

	NULL VALUE AND "is" OPERATOR
	
	a variable with a class type that is not initialized with "new" does not reference an (anonymous) class object
	in order to check if the variable is null, do not use '==', use the "is" operator:
		if(someObj is null)
		!is can also be used
	assigning null to an associative array breaks the relationship between the variable and the elements
	

	TYPE CONVERSION
	
	if arithmetic involves one real value, then the other variable is converted to real, same with double and float
	C-like explicit conversions are supported
		int someVar;
		const someConst = double(someVar)/2;
	to!TYPE(object) is also an explicit conversion using the to() template function, also supports immutable conversions
	assumeUnique() makes the elements of a slice immutable without copying and makes the original slice null
		int[] numbers ...
    	auto immutableNumbers = assumeUnique(numbers);
	to() ensures safe conversions, cast(destinationType) does not
	cast() can convert between pointer and non-pointer types as well
	

	STRUCTS
	
	immutable objects must be created with a construction object since members cannot be modified
		immutable obj = S(x, y);
	slice members will be linked between copies unless copied through .dup
		auto someObj = S(i, [x, y, z]);
		auto someObj2 = S(i, someObj.slice.dup); <- without dup, someObj and someObj2 share the same slice
	static this() blocks are automatically executed once PER THREAD before a struct type is ever used in that thread.
		struct Point {
			enum nextIdFile = "Point_next_id_file";
		
			static this() {
			if (exists(nextIdFile)) {
				auto file = File(nextIdFile, "r");
				file.readf(" %s", &nextId); 
			}
		}
	shared static this() blocks will be executed only once in the entire program regardless of the number of threads
	Similarly, static ~this() is for the final operations of a thread, and shared static ~this() is for the final operations of the entire program
	

	COMPILE-TIME LITERALS
	
    __MODULE__: Name of the module as a string
    __FILE__: Name of the source file as a string
    __FILE_FULL_PATH__: Name of the source file including its full path as a string
    __LINE__: Line number as an int
    __FUNCTION__: Name of the function as a string
    __PRETTY_FUNCTION__: Full signature of the function as a string
	

	VARIADIC FUNCTION ARGUMENTS
	
	`void someFunc(T[] args...)`
	if there will be use of the slice holding the variadic arguments later, then a duplicate must be made
	

	SPECIAL MEMBER FUNCTIONS
	
	constructors are defined through "this()"
	destructors are defined through "~this()"
	copy constructor is defined through "this(this)"
		slices should be copied through ".dup" in the copy constructor definition
    assignment operator is defined through "opAssign()"
		struct T {
			T opAssign(T rhs) {
				this.member = rhs.member;
        		return this;
			}
		}
	members are access through "this.MEMBER"
	immutable members can be constructed through construction, but not assignment
		immutable int i;
		this.i = iArg; <- Construction
		this.i = iArg <- Compiler error: assignment to immutable variable
	default constructors are defined through "static opCall()"
		struct T {
			static T opCall() {
				...
				T obj;
				return obj;
			}
		}
	Dlang supports const, immutable, and shared qualifiers
	default constructor can be disabled through "@disable this();"
	

	OPERATOR OVERLOADING
	
	operators are overloaded through template functions
	the function names are:
		opBinary(+, -, *, /, %, ^^, &, |, ^, <<, >>, >>>, ~, in)
		opEquals(==, !=)
		opCmp(<, <=, >, >=)
		opAssign(=)
		opOpAssign(+=, -=, *=, /=, %=, ^^=, &=, |=, ^=, <<=, >>=, >>>=, ~=)
	struct T {
		int var;
		ref T opAssign(string op)() {
			if(op == "++") {
				++minute;
			}
			return this;
		}
		ref T opAssign(string op)() {
			if(op == "--") {
				--minute;
			}
			return this;
		}
		ref T opOpAssign(string op)(int num) {
			if(op == "+") {
				var += num;
			}
			return this;
		}
	}
	
	Mixins can also be used to "attach" arguments/representations of code to actual code to be executed
	opDollar:
		Since it returns the number of elements of the container, the most suitable type for opDollar is size_t. However, the return type can be other types as well (e.g., int).
	Unconstrained operators:
		The return types of some of the operators depend entirely on the design of the user-defined type;they include the unary *, opCall, opCast, opDispatch, opSlice, and all opIndex varieties.
	For the two objects that opEquals returns true, opCmp must return zero
	For the user-defined opCmp() to work correctly, this member function must return a result according to the following rules:
		A negative value is returned if the left-hand object is considered to be before the right- hand object in the order chosen (ascending/descending).
		A positive value is returned if the left-hand object is considered to be after the right-hand object.
		Zero is returned if the objects are considered to have the same sort order
		You can use std.algorithm.cmp for comparing slices (including all string types and ranges). cmp() compares slices lexicographically and produces a negative value, zero, or positive value depending on their order.
			That result can be used directly as the return value of opCmp
	static opCall() allows creating objects with default values at run time.
	non-static opCall() allows using the objects of user-defined types as functions
	opIndex, opIndexAssign, opIndexUnary, opIndexOpAssign, and opDollar make it possible to use indexing operators on user-defined types similar to arrays as in object[index]
		opIndexAssign is for assigning a value to an element. The first parameter is the value that is being assigned, and the second parameter is the index of the element
		opIndexUnary is similar to opUnary. The difference is that the operation is applied to the element at the specified index
		opIndexOpAssign is similar to opOpAssign. The difference is that the operation is applied to an element
		opDollar defines the ＄ character that is used during indexing and slicing. It is for returning the number of elements in the container
