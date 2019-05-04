function res = has_ded(M, n)
  res = true;
  for i=1 : n
    ded = sum( abs(M(i,:)) >= abs(M(i, i)));
    if (ded != 1) 
      res = false;
      return;
    endif
  endfor
endfunction