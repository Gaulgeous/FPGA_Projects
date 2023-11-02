error = hw_refined - sw_refined;
error_p = sum(error.^2);
orig_p = sum(sw_refined.^2);

ser = 10*log10(error_p/orig_p)