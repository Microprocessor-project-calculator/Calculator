# Calculator
This is our mini calculator project, it’s made to deal with all mathematical operation which we use in our daily life. 
We take an expression from user as a string, and then we deal with all numerical and characters in this expression. 

**The input and output example**: 

![first](https://user-images.githubusercontent.com/76706477/103562678-210d2c00-4ec4-11eb-97d8-91fcfb832c7f.jpg)

 

Firstly, we make a cpp code which deal with all functions that we need, after that we turn every instruction to assembly by help of reference: **assembly language for x86 processors**, which were a really helpful to deal with **jmp**, **cmp** function

**Example of our usage:** 

![photo6023569634550199601](https://user-images.githubusercontent.com/76706477/103562904-8cef9480-4ec4-11eb-8606-6cbf9d46fb2b.jpg)

 

# To make a good understanding about our project:
>note that: String can’t be held as it is in assembly code, so we made a **“buffer”** which is array of 30 bytes, which held the expression that user entered. 

>note also:The Epb is a (base pointer) register which we use to point to byte by byte in the expression which user enter -Which held in buffer- . 

**Notice these labels:**

**Sign** is represent if the number is positive: represented by 1. Or negative: represented by -1.

**result** held the answer of entered expression, after doing all entered operations, so it’s DWord: 4bytes.

**Co** only represented by 1 or 2, which indicates that if co is 1, then there’s multiplication operation. 
If it’s 2, so it indicates that there’s a division operation, for that it’s only 2 bytes: a word. 

**aux** it’s hold the number after multiplication/division operation. 

**nr** is hold the number changes during operation.

![photo6023569634550199600](https://user-images.githubusercontent.com/76706477/103562836-67fb2180-4ec4-11eb-90bf-ff9ce5898a1f.jpg)

 
