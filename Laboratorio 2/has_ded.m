function res = has_ded(M, n)
  for i=1 : n
    ded = sum( abs(M(i,:)) >= abs(M(i, i)));
    if (ded == 1) 
      res = true;
    else
      res = false;
    endif
  endfor
endfunction