#include <stdio.h>
#include <math.h>
#include <windows.h>

float function1(float x)
{
    x=pow(x,3);
    return x;
}

float function2(float x,float y,float z)
{
    float result;
    result=x*y*z;
    return result;
}

int main()
{
    float x,y,z;
    printf("Input variable x\n");
    scanf("%f", &x);
    printf("Input variable y\n");
    scanf("%f", &y);
    printf("Input variable z\n");
    scanf("%f", &z);
    float fx;
    fx=function1(x)+function2(x,y,z);
    printf("The value of f(x)=(x^3)+(x*y*z) is %.2f", fx);
    Sleep(3*1000);
    return 0;


}
