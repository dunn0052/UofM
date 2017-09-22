1. 3 - 2 + 4
Legal
type: int
value: int 5

2. 3.14 * 6 * 6
Not legal
You can't multiply an int with a float using *

3. if 1 then 3 else 4
Not legal
The if statement thinks that "if 1" is a boolean statement and won't output the ints 3 or 4

4. if 1>0 then 2 else "no"
Not legal
The if else statement only returns one type of data and "no" is not an integer like 2

5. let x = 42 in 42 + y
Not legal
y in the statement 42 + y is not defined

6. let circ d = 3.14*.d in circ 4
Not legal
circ 4 is not a float and can't be multiplied by the int 4

7. let circ d = 3.14*.d in circ 4.0
Legal
value: float 12.56

8. let x = 2 in let y = x + 3 in let x = y + x in x
Legal
value: int 7

9. let z z = z ^ "z" in z "cheez"
Legal
value: string "cheezz"

10. let x = "one" in let y = 1,x in let x = 2 in y+x
Not legal
You can't add an int with a string
