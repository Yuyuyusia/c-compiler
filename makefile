obj = sample
fn = .c
test = sample3
all:
	make gen_comp
	make compile
	make gcc
	make llvm

gen_comp:
	lex lex.l
	yacc yacc.y
	yacc -d yacc.y
	cc lex.yy.c y.tab.c -o cpl

compile:
	for num in 1 2 3 4 5 6 7; do\
		./cpl < $(obj)$$num$(fn) ;\
	./cpl < $(test).c;\
	done

gcc:
	gcc -E $(test).c -o $(test)_pre
	gcc -S $(test).c -o $(test)_arm
	gcc -S -masm=intel $(test).c -o $(test)_intel

llvm:
	clang -S -emit-llvm $(test).c
	opt -S -globalopt -loop-simplify -mem2reg $(test).ll
	llc $(test).ll
	as $(test).s -o $(test).o
	ld $(test).o -o $(test)_llvm -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2