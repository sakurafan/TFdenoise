function isnr_val=isnr(D_clear,D_noised,D_denoised)
isnr_val=10*log10(  sum(   (D_clear(:)-D_noised(:)).^2   )   /  sum(  (D_clear(:)-D_denoised(:)).^2  )  );