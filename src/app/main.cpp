#include <iostream>
#include <test/echo_sum.h>
#include <util/add.h>
int main(int argc, char **argv)
{
    CalcResulter cla;
    std::cout<<"excutable"<<'\n';
    std::cout<<add(9, 99)<<'\n';
    cla.echo_sum();
}
