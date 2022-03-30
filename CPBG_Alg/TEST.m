x = -2:0.5:2;
y = exp(x) - exp(1);
sigmoid = 1 \ (1 + exp(x));
tanh = (exp(x)-exp(-x))./(exp(x)+exp(-x));
plot(x, y)