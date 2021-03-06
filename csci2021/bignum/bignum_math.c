
/**************************
 * bignum_math.c -- an outline for CLab1
 *
 * orginially written by Andy Exley
 * modified by Emery Mizero
 * completed by Kevin Dunn
 **************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bignum_math.h"

//false spelled in base 36 - used to print bool with bignum_print
int f_alse[6] = {15,10,21,28,14,-1};
	
//true spelled in base 36 - used to print bool with bignum_print
int t_rue[5] = {29,27,30,14,-1};


/*
 * Returns true if the given char is a digit from 0 to 9
 */
bool is_digit(char c) {
	return c >= '0' && c <= '9';
}

/*
 * Returns true if lower alphabetic character
 */
bool is_lower_alphabetic(char c) {
	return c >= 'a' && c <= 'z';
}

/*
 * Returns true if upper alphabetic character
 */
bool is_upper_alphabetic(char c) {
	return c >= 'A' && c <= 'Z';
}

/*
 * Convert a string to an integer
 * returns 0 if it cannot be converted.
 */
int string_to_integer(char* input) {
	int result = 0;
	int length = strlen(input);
    int num_digits = length;
	int sign = 1;
	
	int i = 0;
    int factor = 1;

    if (input[0] == '-') {
		num_digits--;
		sign = -1;
    }

	for (i = 0; i < num_digits; i++, length--) {
		if (!is_digit(input[length-1])) {
			return 0;
		}
		if (i > 0) factor*=10;
		result += (input[length-1] - '0') * factor;
	}

    return sign * result;
}

/*
 * Returns true if the given base is valid.
 * that is: integers between 2 and 36
 */
bool valid_base(int base) {
	if(!(base >= 2 && base <= 36)) { 
		return false; 
	}
	return true;
}



/*
 * converts from an array of characters (string) to an array of integers
 */
int* string_to_integer_array(char* str) {
	int* result;
	int i, str_offset = 0;
		result = malloc((strlen(str) + 1) * sizeof(int));
		result[strlen(str)] = -1;
	for(i = str_offset; str[i] != '\0'; i++) {
		if(is_digit(str[i])) { 
			result[i - str_offset] = str[i] - '0';
		} else if (is_lower_alphabetic(str[i])) {
			result[i - str_offset] = str[i] - 'a' + 10;
		} else if (is_upper_alphabetic(str[i])) {
			result[i - str_offset] = str[i] - 'A' + 10;
		} else {
			printf("I don't know how got to this point!\n");
		}
	}
	return result;
}

//Copies int arrays to use as dummy for valid input comparison
void integer_array_copy(int* num1, int* num2){
	int len = bignum_length(num1);
	int i = 0;
	while(i < len){
		num2[i] = num1[i];
		i++;
	}
}

//checks to see if input is neg and every digit is less than the base
bool valid_input(char* input, int base) {
	if(input[0] == '-'){
		printf("This calculator doesn't handle negative inputs.\n");
		return false;
	}
	int i = 0;
	int len = bignum_length(string_to_integer_array(input));
	int* num;
	num = (int*) malloc(len);
	integer_array_copy(string_to_integer_array(input), num);
	while(i < len){
		if(num[i] >= base){
			return false;
		}
	i++;
	}
	
	return true;
}

/*
 * finds the length of a bignum... 
 * simply traverses the bignum until a negative number is found.
 */
int bignum_length(int* num) {
	int len = 0;
	int i = 0;
	bool check = true;
	while(num[i] > -1) {
	if(num[i] == 0 && check)
	{i++;}
	else
	{check = false;
	len++;
	i++; }
	}
	return len;
}


//modified bignum_print - prints everything!
void bignum_print(int* num) {
	// handles negative numbers
	if(num[0] < 0){
		printf("-");
		num[0] *= -1;
	}
	
	int i = 0;
	if(num == NULL) { return; }
	//leading zero flag
	bool check = true;
	
	/* Then, print each digit */
	while(num[i] > -1) {
		//get rid of leading zeros from subtraction - except when result is 0
		while(num[i] == 0 && check){
			i++;
			if(num[i] == -1){
				printf("0");
				return;
			}
		}
		check = false;
		
		if(num[i] <= 9){
		printf("%d", num[i]);
		}
		else if(num[i] > 9){
			printf("%c", num[i] + 87);
		}	
		i++;
	}
	printf("\n");
}


/*
 *	Helper for reversing the result that we built backward.
 *  see add(...) below
 */
void reverse(int* num) {
	int i, len = bignum_length(num);
	for(i = 0; i < len/2; i++) {
		int temp = num[i];
		num[i] = num[len-i-1];
		num[len-i-1] = temp;
	}
}


/*
 * used to add two numbers with the same sign
 * GIVEN FOR GUIDANCE
 */
int* add(int* input1, int* input2, int base) {
	int len1 = bignum_length(input1);
	int len2 = bignum_length(input2);
	int resultlength = ((len1 > len2)? len1 : len2) + 2;
	int* result = (int*) malloc (sizeof(int) * resultlength);
	int r = 0;
	int carry = 0;
	int sign = input1[len1];
   	int num1, num2;

	len1--;
	len2--;

	while (len1 >= 0 || len2 >= 0) {
        if (len1 >= 0) {
            num1 = input1[len1];
        } else {
            num1 = 0;
        }

        if (len2 >= 0) {
            num2 = input2[len2];
        } else {
            num2 = 0;
        }
		result[r] = (num1 + num2 + carry) % base;
		carry = (num1 + num2 + carry) / base;
		len1--;
		len2--;
		r++;
	}
	if (carry > 0) {
        result[r] = carry; 
        r++; 
    }
	result[r] = sign;
	reverse(result);
	return result;
}

//checks length then traverses array for the first digit difference
int* less_than(int* input1, int* input2){

	
	int len1 = bignum_length(input1);
	int len2 = bignum_length(input2);
	reverse(input1);
	reverse(input2);
	if(len1 < len2){
		return t_rue;
	}
	else if(len1 == len2){
		while(input1[len1] == input2[len1]){
			if(len1 == 0) 
			{
				return f_alse;
			}
			len1--;
		}
		if(input1[len1] < input2[len1])
		{
			return t_rue;
		}
		else if(input1[len1] > input2[len1]){
			return f_alse;
		}
	}
	return f_alse;
	
}

//checks length then traverses array for the first digit difference
int* greater_than(int* input1, int* input2){

	int len1 = bignum_length(input1);
	int len2 = bignum_length(input2);
	reverse(input1);
	reverse(input2);
		if(len1 > len2){
		return t_rue;
	}
	else if(len1 == len2){
		while(input1[len1] == input2[len1]){
			if(len1 == 0) 
			{
				return f_alse;
			}
			len1--;
		}
		if(input1[len1] > input2[len1])
		{
			return t_rue;
		}
		else if(input1[len1] < input2[len1]){
			return f_alse;
		}
	}
	return f_alse;
	
}

//checks length then traverses array for the first digit difference
int* equal_to(int* input1, int* input2){

	
	int len1 = bignum_length(input1);
	int len2 = bignum_length(input2);
	reverse(input1);
	reverse(input2);
		if(len1 > len2){
		return f_alse;
	}
	else if(len1 == len2){
		while(input1[len1] == input2[len1]){
			if(len1 == 0) 
			{
				return t_rue;
			}
			len1--;
		}
		if(input1[len1] > input2[len1])
		{
			return f_alse;
		}
		else if(input1[len1] < input2[len1]){
			return f_alse;
		}
	}
	return f_alse;
	
}


int* subtract(int* input1, int* input2, int base) {
	
	int len1 = bignum_length(input1);
	int len2 = bignum_length(input2);
	int resultlength = (len1 + 2);
	int* result = (int*) malloc (sizeof(int) * resultlength);
	int r = 0;
    int num1, num2;
    
	//checks for negative difference, performs subtract from in2 to in1 and
	// and sets flag for negative result 
	if(less_than(input1, input2) == t_rue){
		//reverse the reverse from initial call
		reverse(input1);
		reverse(input2);
		result = subtract(input2, input1, base);
		int i = 0;
		while(!result[i]){
			i++;
		}
		result[i] *= -1;
		return result;
	}

	len1--;
	len2--;
	//subtract from slallest digit first
	reverse(input1);
	reverse(input2);
	
	while(len1 >= 0)
	{
		num1 = input1[len1];

        if (len2 >= 0) {
            num2 = input2[len2];
        } else {
            num2 = 0;
        }
        if(num1 < num2)
        {
        	num1 = num1 + base;
        	result[r] = (num1 - num2);
        	input1[len1 - 1]--;
        printf(" car %d - %d = %d\n", num1, num2, result[r]);
			
		}
		else
		{
			result[r] = (num1 - num2);
		printf("reg %d - %d = %d\n", num1, num2, result[r]);
		}
	len1--;
	len2--;
	r++;
	printf("\n%d len1\n", len1);
	}
	result[r] = -1;
	//reverse to return result forward
	reverse(result);
	printf("\n");
	return result;
}




int* perform_math(int* input1, int* input2, char op, int base) {

	/* 
	 * this code initializes result to be large enough to hold all necessary digits.
	 * if you don't use all of its digits, just put a -1 at the end of the number.
	 * you may omit this result array and create your own.
    	 */

   	int len1 = bignum_length(input1);
   	int len2 = bignum_length(input2);
	int resultlength = ((len1 > len2)? len1 : len2) + 1;
	int* result = (int*) malloc (sizeof(int) * resultlength);
 
	if(op == '+') {
		return add(input1, input2, base);
	}
	if(op == '-'){
		return subtract(input1, input2, base);
	}
	if(op == '<'){
		return less_than(input1, input2);
	}
	if(op == '>'){
		return greater_than(input1, input2);
	}
	if(op == '='){
		return equal_to(input1, input2);
	}
	return result;
}

/*
 * Print to "stderr" and exit program
 */
void print_usage(char* name) {
	fprintf(stderr, "----------------------------------------------------\n");
	fprintf(stderr, "Usage: %s base input1 operation input2\n", name);
	fprintf(stderr, "base must be number between 2 and 36, inclusive\n");
	fprintf(stderr, "input1 and input2 are arbitrary-length integers\n");
	fprintf(stderr, "Two operations are allowed '+' and '-'\n");
	fprintf(stderr, "----------------------------------------------------\n");
	exit(1);
}



int main(int argc, char** argv) {
	int input_base;

    int* input1;
    int* input2;
    int* result;

	if(argc != 5) { 
		print_usage(argv[0]); 
	}

	input_base = string_to_integer(argv[1]);

	if(!valid_base(input_base)) { 
		fprintf(stderr, "Invalid base: %s\n", argv[1]);
		print_usage(argv[0]);
	}
	

	if(!valid_input(argv[2], input_base)) { 
		fprintf(stderr, "Invalid input1: %s\n", argv[2]);
		print_usage(argv[0]);
	}

	if(!valid_input(argv[4], input_base)) { 
		fprintf(stderr, "Invalid input2: %s\n", argv[4]);
		print_usage(argv[0]);
	}

        char op = argv[3][0];
	if(op != '-' && op != '+' && op != '<' && op != '>' && op != '=') {
		fprintf(stderr, "Invalid operation: %s\n", argv[3]);
		print_usage(argv[0]);
	}

	input1 = string_to_integer_array(argv[2]);
    input2 = string_to_integer_array(argv[4]);

    result = perform_math(input1, input2, argv[3][0], input_base);

    printf("Result: ");
    bignum_print(result);
	printf("\n");

	exit(0);
}
