# Calculator
This is our mini calculator project, it’s made to deal with all mathematical operation which we use in our daily life. 
We take an expression from user as a string, and then we deal with all numerical and characters in this expression. 

**The input and output example**: 

![first](https://user-images.githubusercontent.com/76706477/103562678-210d2c00-4ec4-11eb-97d8-91fcfb832c7f.jpg)

 

Firstly, we made a cpp code -which appears in resources below- that deal with all functions that we need, after that we turn every instruction to assembly by help of reference: **assembly language for x86 processors**, which was really helpful to deal with **jmp**, **cmp** functions

**Example of our usage:** 

![photo6023569634550199601](https://user-images.githubusercontent.com/76706477/103562904-8cef9480-4ec4-11eb-8606-6cbf9d46fb2b.jpg)


# To make a good understanding about our project:
>note: String can’t be held as it is in assembly code, so we made a **“buffer”** which is array of 30 bytes, which held the expression that user entered. 

>note: The **Epb** is a (base pointer) register which we use to point to byte by byte in the expression which user enter -Which held in buffer- . 

**Notice these labels:**

**Sign** is represent if the number is positive: represented by 1. Or negative: represented by -1.

**result** held the answer of entered expression, after doing all entered operations, so it’s DWord: 4bytes.

**Co** only represented by '1' or '2', which indicates that if **co** is 1, then there’s multiplication operation. 
If it’s '2', so it indicates that there’s a division operation, for that it’s only 2 bytes: a word. 

**aux** it’s hold the number after multiplication/division operation. 

**nr** is hold the number changes during operation.

![photo6023569634550199600](https://user-images.githubusercontent.com/76706477/103562836-67fb2180-4ec4-11eb-90bf-ff9ce5898a1f.jpg)

 
# Overview:
**In code**:
we use ***start*** to represent the `infinite loop` in which user can use the program to write expression more than one time, by `jmp` to this label at the ***answer*** section at the end of program:
**Entering more than one expression:

![e12547d6-e81d-4c1d-a7d6-2d6458692a17](https://user-images.githubusercontent.com/76706477/103569534-27a1a080-4ed0-11eb-90de-41cb8b5884af.jpg)

***Loop1*** and ***digit*** sections are indicating functions which check the number of digits which entered by user and seperate digit by digit, recognise that in this section we used a special `mov` which is `movzx` to mix size of 32bit register and 16bit register:


![4eeb0392-f1df-49bd-b542-a1dd437cfc7f](https://user-images.githubusercontent.com/76706477/103569674-659ec480-4ed0-11eb-8e13-b2922d7fc7ee.jpg)


after that, we have ***switch*** section in which we check if entered symbol is: '+','-','\*','/' or other.
Depending on the entered symbol we `je` to required label: ***addition***, ***substraction***, ***multiplication*** or ***Division***
There's also ***psign*** and ***nsign*** labels which indicates positive and negative sign.
in ***incre*** we only increment the value of **Ebp** register by one to move to next digit.
finally, in ***answer*** section we `mov` the final value to the result and show it and return to begin to retry all the program again to make user able to write many expressions as he wanted.















**Resources:**

[Assembly Language for x86 Processors, 6th Edition](https://www.pearson.com/uk/educators/higher-education-educators/program/Irvine-Assembly-Language-for-x-86-Processors-6th-Edition/PGM965305.html)

[prentice the intel microprocessors, 8th edition](https://userpages.umbc.edu/~squire/intel_book.pdf)

[c++ code](https://github.com/Microprocessor-project-calculator/Calculator/blob/master/Calculator/Calculator.cpp)


