function pk = nextPoint(M, b, p, n)
  pk = [];
  for i=1 : n
    xi = b(i);
    r = M(i, :) .* p .* -1;
    r = [r(1 : i-1), r(i+1 : n)];
    xi += sum(r);
    xi /= M(i, i);
    pk(i) = xi;
  endfor
endfunction
