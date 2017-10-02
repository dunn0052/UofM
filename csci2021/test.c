#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bignum_math.h"

void reverse(int* num) {
	int i, len = bignum_length(num);
	for(i = 0; i < len/2; i++) {
		int temp = num[i];
		num[i] = num[len-i-1];
		num[len-i-1] = temp;
	}
}


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
 * Returns true if the given base is valid.
 * that is: integers between 2 and 36
 */
bool valid_base(int base) {
	if(!(base >= 2 && base <= 36)) { 
		return false; 
	}
	return true;
}

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

int bignum_length(int* num) {
	int len = 0;
	while(num[len] >= 0) { len++; }
	return len;
}

int* subtract(int* input1, int* input2, int base){
	printf("subtract");
	int len1, result_length = bignum_length(input1);
	int len2 = bignum_length(input2);
	reverse(input1);
	reverse(input2);
	int i = 0;
	int r = 0;
	
	int* result = (int*) malloc (sizeof(int) * result_length);
	while (len1 >= 0) {
		if(input1[len1] < input2[len1]){
			input1[len1 - 1]--;
			input1[len1] = input1[len1] + base;
			result[r] = (input1[len1] - input2[len1]);
			
		}
		else{
			result[r] = (input1[len1] - input2[len2]);
		}
		len1--;
		r++;
	}
		result[r] =  -1;
		return result;
	}

void bignum_print(int* num) {
	int i;
	if(num == NULL) { return; }

	/* Handle negative numbers as you want */
	i = bignum_length(num);

	/* Then, print each digit */
	for(i = 0; num[i] >= 0; i++) {
		if(num[i] < 9 ){
		printf("%d", num[i]);
		}
		else if(num[i] > 9){
			printf("%c", num[i] + 87);
		}	
	}
	printf("\n");
}

int main(int argc, char** argv){
	
	int input_base;

    int* input1;
    int* input2;
    int* result;
    
    input1 = string_to_integer_array(argv[2]);
    input2 = string_to_integer_array(argv[4]);
	input_base = string_to_integer(argv[1]);
	

	result = subtract(input1, input2, input_base);
	bignum_print(result);
	printf("%i%i%c%i", argv[1], argv[2], argv[3], argv[4]);
	
	exit(0);
}
