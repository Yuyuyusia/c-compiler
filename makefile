obj = sample
fn = .c
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
	done

gcc:
	gcc -E sample3.c -o sample3_pre
	gcc -S sample3.c -o sample3_arm
	gcc -S -masm=intel sample3.c -o sample3_intel

llvm:
	clang -S -emit-llvm sample3.c
	opt -S -globalopt -loop-simplify -mem2reg sample3.ll
	llc sample3.ll
	as sample3.s -o sample3.o
	ld sample3.o -o sample3_llvm -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2


