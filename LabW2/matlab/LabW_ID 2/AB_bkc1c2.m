function [A, B] = AB_bkc1c2(bkc1c2, J1, J2)

b = bkc1c2(1);
k = bkc1c2(2);
c1 = bkc1c2(3);
c2 = bkc1c2(4);

A = [ -c1/J1    0    -k/J1;
         0   -c2/J2   k/J2;
         1     -1      0   ];
B = [   b/J1    0      0   ]';
