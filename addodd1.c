int main()
{
	int count = 0;
	int i = 1;
	for (i=1; i<=100; i++) {
		if (i % 2 != 0)continue;
		else{
			count = count + i;
		}
	};
	printf( "add all odd numbers in 1 ~ 100 : ") ;
	printf( "%d", count );
	return 0;
}
