#include <stdio.h>
int main()
{
	int a,b,s,c;
	printf("Input the value of bit A:\n");
	scanf("%d", &a);
	printf("Input the value of bit B:\n");
	scanf("%d", &b);
	s=a^b;
	c=a&b;
	printf("The value of s is %d\n", s);
	printf("The value of c is %d", c);
	return 0;

	/*Ypotithetai oti o xrhsths tha dwsei 0 h 1, diaforetika to programma den doulevei
	An thelame na apokleisoume times diafores tou 0 kai tou 1 tha mporousame na to kanoume eite me while eite me metavlhth typou bool
    To programma mporei epishs na ylopoihthei me entoles if.... else if*/
}
