#include <stdio.h>
void swap(int *n1, int *n2){
	int temp=*n1;
	*n1=*n2;
	*n2=temp;
}       

int main(){
	int a=84, b=56, c;
	printf("a=%d b=%d ",a,b);
	if (a==0 || b==0) return 0;
	if (b>a) swap(&a,&b);
	while (a%b){
		c=a;
		a=b;
		b=c%b;
	}       
	printf("gcd=%d\n",b);
	return 0;
}                   	