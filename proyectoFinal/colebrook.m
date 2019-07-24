function r = colebrook (e , d, re, c)
  fa=1 ./ sqrt(c);
  fb=-2 .* (log((e ./ d) ./ 3.71 .+ 2.51 ./ (re .* sqrt(c)))) .* 0.434294481903252000;
  r=fb .- fa;
endfunction