fucntion y = test(maxLoop)
x=(1:1000)';
for k=1:maxLoop
    y(:,k) = k*log(x);
end
plot(x,y)
