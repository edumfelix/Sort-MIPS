.data
arr: .word 2 6 7 1 3 4 5 9 8 0 # Array
n: .word 10 # Tamanho do Array

.text
main:	
	la $t1, arr # Endereço de memória do primeiro elemento
	lw $s0, n # Tamanho do Array: n = 10;
	subu $s0, $s0, 1 # n - 1;
	
	addu $s5, $zero, $zero # swap = 0;
	addu $s1, $zero, $zero # indice = 0;
for:
	lw $t4, ($t1) #arr(i);
	addu $s2, $zero, $zero # j = 0;
	
	subu $t9, $s0 $s1 # n - i - j;
	internalFor:
		addu $t2, $t1, 4 # endereço de memória do próximo elemento
		lw $t4, ($t1) # arr[j];
		lw $t5, ($t2) # arr[j+1];
		
		bleu $t4, $t5, dontSwap # arr[j] <= arr[j+1]; goto dontSwap
		
		
		sw $t4, ($t2) # arr[j] = arr[j+1];
		sw $t5, ($t1) #arr[j+1] = arr[j];
		
		addu $s5, $zero, 1 #swap = 1;
		
		dontSwap:
		
		beq $s2, $t9, endInternalFor # j == n - i - 1 goto endInternalFor
		addu $s2, $s2, 1 # j++;
		addu $t1, $t1, 4 # endereço de memória do próximo elemento para j
		addu $t2, $t2, 4 # endereço de memória do próximo elemento para j+1
		b internalFor # j < n - i - j goto internalFor
		
	endInternalFor:
	
	beqz $s5, endFor # if (!swap) break; goto endFor
	beq $s1, $s0, endFor # i == n - 1 goto endFor
	addu $s1, $s1, 1 # i++;
	la $t1, arr # Endereço de memória do primeiro elemento
	b for # i < n - 1 goto for
endFor:

la $t1, arr # Endereço de memória do primeiro elemento
and $s1, $zero, $zero # i = 0;

print: 
	lw $a0, ($t1) # arr[i]
	addu $v0, $zero, 1
	syscall
	
	beq $s1, $s0, endPrint # i == n - 1; goto endPrint
	addu $s1, $s1, 1 # i++;
	addu $t1, $t1, 4 # Endereço de memória do próximo elemento
	b print # i < n - 1; goto print
endPrint:
