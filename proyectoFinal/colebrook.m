function r = colebrook (e , d, re, c)
  r = -2*(log((e/d)/3.71+2.51/(re*sqrt(c))))*0.434294481903252000 - 1/sqrt(c);
endfunction