function y = Levy(x)

  d = length(x);

  for i = 1:d
    w(i) = 1 + (x(i) - 1)/4;
  end

  term1 = (sin(pi*w(1)))^2;
  term3 = (w(d)-1)^2 * (1+(sin(2*pi*w(d)))^2);

  sum = 0;
  for i = 1:(d-1)
    wi = w(i);
    new = (wi-1)^2 * (1+10*(sin(pi*wi+1))^2);
    sum = sum + new;
  end

  y = term1 + sum + term3;

end