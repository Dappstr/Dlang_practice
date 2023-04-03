module source.app;

import std.stdio;
import std.conv; // to! conversions
import std.string;
import std.format; // formattedRead()
import std.file;
import std.bitmanip;
import std.traits; // EnumMembers template
import std.range; // stride()
import std.getopt;
import std.random;
import std.process;
import std.exception;
import std.math; //isNaN()

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

void printStrings(string[] strs...) {
	foreach(str; strs) {
		write(str, ' ');
	}
}

struct T {
	int var;
	this(int x) {
		var = x;
	}
	ref T opUnary(string op)()
		if((op == "++") || (op == "--")) {
			mixin(op ~ "var;"); // will run the cose as if whatever "op" is will be replaced with the actual representation of it concatenated with "normal code" (var;)
			return this;
		}
}

struct Number
{
	int[] arr1, arr2;

	this(this) {
		this.arr1 = arr1.dup;
		this.arr2 = arr2.dup;
	}

	ref Number fill() {
		for(int i = 0; i < 10; ++i) {
			arr1 ~= uniform(1, 11);
			arr2 ~= uniform(1, 11);

		}
		return this;
	}

	ref Number opUnary(string op)() {
		if(op == "++" || op == "--") {
			foreach (ref _; arr1) { mixin(op ~ "_;"); }
			foreach (ref _; arr2) { mixin(op ~ "_;"); }
		}
		return this;
	}
}

void main(string[] args)
{

	auto num = T(5);
	++num;
	writeln(num.var);
	--num;
	writeln(num.var);
}
