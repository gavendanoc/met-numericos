function r = V (hf, d, g, Vf, L)
  r = (2 .* hf .* d .* g ./ ( Vf .* L ) ) .^ 0.5;
endfunction