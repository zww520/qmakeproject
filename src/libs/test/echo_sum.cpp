#include "echo_sum.h"
#include <util/add.h>
#include <iostream>
CalcResulter::CalcResulter()
{

}

void CalcResulter::echo_sum()
{
    int a = 10;
    int b = 10;
    int res = add(a, b);
    std::cout<<res<<'\n';
}
