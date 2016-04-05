[c1.f1, c2.f1, k.f1, b.f1] = findSystemParams(2*pi*1, 'f1');
[c1.f2, c2.f2, k.f2, b.f2] = findSystemParams(2*pi*2, 'f2');
[c1.f3, c2.f3, k.f3, b.f3] = findSystemParams(2*pi*3, 'f3');
[c1.f4, c2.f4, k.f4, b.f4] = findSystemParams(2*pi*4, 'f4');
[c1.f5, c2.f5, k.f5, b.f5] = findSystemParams(2*pi*5, 'f5');

fc1 = mean([c1.f1, c1.f2, c1.f3, c1.f4, c1.f5]);
fc2 = mean([c2.f1, c2.f2, c2.f3, c2.f4, c2.f5]);
fk  = mean([k.f1, k.f2, k.f3, k.f4, k.f5]);
fb  = mean([b.f1, b.f2, b.f3, b.f4, b.f5]);