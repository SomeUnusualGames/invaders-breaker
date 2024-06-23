
Hello everyone, today I'm taking a look at a very special and famous/infamous(in·fuh·muhs) esoteric programming language called COBOL.

COBOL is a programming language whose main selling point is its English-like syntax. Released in the 1960s, COBOL was designed to create a portable language for data processing, used primarly on mainframe computers in business, finance and administrative systems. COBOL's background is actually very interesting, I recommend reading its Wikipedia article.

Just like Fortran, there were several standards released, from the first one called COBOL-60 all the way to COBOL-2023. Nowadays there are three major implementations:
- IBM COBOL
- Micro Focus Visual COBOL
- GnuCOBOL [guhnoo /ɡ(ə)ˈnuː/]

Of course, the first two are commercial implementations while the latter is free and open source, which is the one I used.

GnuCOBOL, as it says on its website, transpiles COBOL to C, which is compiled to a native executable. Since it compiles C code, it is possible to use any C library from COBOL without the need of bindings or a foreign function interface. As always, I'm going to use raylib.

As for the game, as you saw at the beggining of the video, I decided to make a mix between Space Invaders and Breakout; I realised a game like this would be simple enough to make in a language like COBOL.

Let's take a look at raylib's hello world program, which must open a window and show text on it.
[open game.cbl]
You'll notice that a lot of stuff that are mandatory in old COBOL are optional with this compiler:
- The first 6 columns can be used to write the line number, or be left empty.
- Comments start with an asterisk at column 7, or use greater than and asterisk to start at any column.
- These have to be followed when using the fixed format. You can pass the parameter `-free` to use the free mode, which you don't have to follow those rules.
- Almost all code is uppercase but that's also optional. COBOL is case-insensitive for both variables and keywords.

Programs are divided in divisions, which can contain sections:
- `IDENTIFICATION DIVISION` contains the name of this program. It's possible to add more information like the author name but that's considered obsolete.
- `DATA DIVISION` contains the variables used in the `WORKING-STORAGE SECTION`.
 The variables are divided into levels. To make variables, you write:
  - The level, from 01 to 49. There are special levels that we'll look in a moment.
  - The name, which can use hypens.
  - `PIC` or `PICTURE`.
  - The format of the variable: nines for the amount of digits the variable will contain, or X for the amount of characters. A single 9 is a variable that goes from 0 to 9, 9(3) is 000 to 999. "S" is for sign, which lets the variable be negative.
  Variables can be grouped: for example, `bg-color` doesn't have a `PIC` because is the name of these three variables grouped.
- `PROCEDURE DIVISION` which contains the procedures with the code. I think in COBOL these are called _paragraphs_, which contain "_sentences_."

You use `CALL` to execute C functions, specifying the parameters and if they are by value or by reference, and even exception handling if the call fails.
Note that `END-CALL` and almost all `END-` something are optional. My convention is to use it when I have to split it into multiple lines.

`PERFORM` can be used for looping and execute procedures.

One limitation of COBOL is that variables can contain numbers or text, but how do we pass a C struct like raylib's `Rectangle` or `Color`?

Notice how we're passing a C file here, where we have a static array of Rectangles and the count. This way, the Rectangles are set with C code, and all we have to do from COBOL is to save the index of the Rectangle in the array. The rest of the code are wrapper functions that take the index of the Rectangle and the R, G, B, A values separately.

You can get values from the C functions with `RETURNING` and the variable.

As you can see, compiling this code works.

About the game's code, instead of walking through the entire codebase, I'll only show you certain part showcasing features of this language:

1. Preprocessor to conditionally compile code
2. Copybooks
3. Special levels (main: 88, enemy-data: 78), EVALUATE
4. enemy-data: arrays
5. ball-data, missile-data: float values with COMP-1 (computational) single precision floating point
6. enemy: perform varying, intrinsic/built-in functions (MOD, RANDOM), verbose: GREATER THAN | >, subprograms
7. ball: no ELSE IF -> generate C code, COMPUTE for multiple operations, 
8. missile: NEXT SENTENCE archaic/bad practice
