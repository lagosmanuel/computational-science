x = 1;

for i=1:100000
  x = x - (x/2) + (1/x);
end

x.^2 + 2
