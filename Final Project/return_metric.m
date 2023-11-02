function errors = return_metric(I_out, I_org, mask, T_m)

    invdcta = @(block_struct) T_m' * block_struct.data * T_m;  %Inverse DCT function

    I_th = blockproc(I_out,[8 8],@(block_struct) mask .* block_struct.data);  % Thersholding for each segment
    I_recon = blockproc(I_th,[8 8],invdcta); %Inverse DCT Operation for each segment

    s1=double(I_recon-I_org).^2;
    sse = sum(sum(s1)); %sum of square error
    if( sse <= 1e-10) 
            psnr=0;
            mse = 0;
    else
         mse  = sse / (double(size(I_recon,1)))^2; % Mean square Error
         psnr = 10.0 * log10((255 * 255) / mse); % peak signal to noise ratio
    end
 
    errors = [mse, psnr];

end