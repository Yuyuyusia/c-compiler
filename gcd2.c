#include <stdio.h>

int main(){
  int a=84,b=56,c;
  while (a%b){
    c = a;
    a = b;
    b = c % b;
  }
  printf("%d\n",b);
  return 0;
}
