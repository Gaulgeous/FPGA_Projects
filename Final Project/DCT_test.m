close all; 
clear all; clc;

%Software Design

% Fixed-point word lengths for signal
W=16;
D=0;

% Fixed-point word lengths for filter coefficients
Wa = 16;
Da=0;

%Input 256*256 gray scale image
I_org=double(imread("lena.jpg","jpg"));  
% Load the image in to workspace

%1D-8-point ideal DCT Matrix
% T_m = dctmtx(8); 


%%%%1D-ADCT Matrix
%%%%U. S. Potluri, A. Madanayake, R. J. Cintra, F. M. Bayer, S. Kulasekera, and A. Edirisuriya, “Improved 8-Point Approximate DCT for Image and Video Compression Requiring Only 14 Additions,” IEEE Transactions on Circuits and Systems I: Regular Papers, vol. 61, no. 6, pp. 1727–1740, 2014
%%%Section 4

T= [ 1  1  1  1  1  1  1  1;
     0  1  0  0  0  0 -1  0;
     1  0  0 -1 -1  0  0  1;
     1  0  0  0  0  0  0 -1;
     1 -1 -1  1  1 -1 -1  1;
     0  0  0  1 -1  0  0  0;
     0 -1  1  0  0  1 -1  0;
     0  0  1  0  0 -1  0  0];        %%% low-complexity matrix

 Diag= [ 1/sqrt(8)  0  0  0  0  0  0  0;
         0   1/sqrt(2)  0  0  0  0  0  0;
         0  0  1/2 0  0  0  0  0;
         0  0  0   1/sqrt(2)  0  0  0  0;
         0  0  0  0   1/sqrt(8)  0  0  0;
         0  0  0  0  0   1/sqrt(2)  0  0;
         0  0  0  0  0  0  1/2  0;
         0  0  0  0  0  0  0   1/sqrt(2)];    %%% Diagonal Matrix

T_m= Diag*T;
% T_m = Di;
% Here, for hardware implementation, you only need to implement T matrix.
% The diagonal matrix "Diag" is typically absorbed into quantisation of the
% computed ADCT coefficients, and can thus be implemented in software.

%2-D DCT operation
% T_m = dctmtx(8);
dct = @(block_struct) T_m * block_struct.data * T_m';   % DCT function
I_dct = blockproc(I_org,[8 8],dct); %DCT Operation for each segment

%Mask for the Threshloding
mask_1 = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];

mask_2 = [1   1   1   1   1   1   0   0
        1   1   1   1   0   0   0   0
        1   1   1   1   0   0   0   0
        1   1   1   1   0   0   0   0
        1   0   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];   %%%You can chage the mask function and check the Image quality.

mask_3 = ones([8, 8]);

mses = [];

sim_in = [];

len = 1024;
dimensions = size(I_org);

for j = 0 : (dimensions(1) / 8)-1

    row = [];
%     fprintf('row %d\n', j)

    for i = 0 : (dimensions(1) / 8)-1

%         fprintf('col %d', i)

        start_x = 1+i*8;
        start_y = 1+j*8;

        im_in = I_org(start_y:start_y+7, start_x:start_x+7);

        sim_in = cat(3, sim_in, im_in);

    end
end

index = 1:1:len;
index = index.';

a = sim_in(1:8,1,:);
b = sim_in(1:8,2,:);
c = sim_in(1:8,3,:);
d = sim_in(1:8,4,:);
e = sim_in(1:8,5,:);
f = sim_in(1:8,6,:);
g = sim_in(1:8,7,:);
h = sim_in(1:8,8,:);

a = reshape(a, [8, len]);
b = reshape(b, [8, len]);
c = reshape(c, [8, len]);
d = reshape(d, [8, len]);
e = reshape(e, [8, len]);
f = reshape(f, [8, len]);
g = reshape(g, [8, len]);
h = reshape(h, [8, len]);

a1 = horzcat(index, a(1, :).');
a2 = horzcat(index, a(2, :).');
a3 = horzcat(index, a(3, :).');
a4 = horzcat(index, a(4, :).');
a5 = horzcat(index, a(5, :).');
a6 = horzcat(index, a(6, :).');
a7 = horzcat(index, a(7, :).');
a8 = horzcat(index, a(8, :).');

b1 = horzcat(index, b(1, :).');
b2 = horzcat(index, b(2, :).');
b3 = horzcat(index, b(3, :).');
b4 = horzcat(index, b(4, :).');
b5 = horzcat(index, b(5, :).');
b6 = horzcat(index, b(6, :).');
b7 = horzcat(index, b(7, :).');
b8 = horzcat(index, b(8, :).');

c1 = horzcat(index, c(1, :).');
c2 = horzcat(index, c(2, :).');
c3 = horzcat(index, c(3, :).');
c4 = horzcat(index, c(4, :).');
c5 = horzcat(index, c(5, :).');
c6 = horzcat(index, c(6, :).');
c7 = horzcat(index, c(7, :).');
c8 = horzcat(index, c(8, :).');

d1 = horzcat(index, d(1, :).');
d2 = horzcat(index, d(2, :).');
d3 = horzcat(index, d(3, :).');
d4 = horzcat(index, d(4, :).');
d5 = horzcat(index, d(5, :).');
d6 = horzcat(index, d(6, :).');
d7 = horzcat(index, d(7, :).');
d8 = horzcat(index, d(8, :).');

e1 = horzcat(index, e(1, :).');
e2 = horzcat(index, e(2, :).');
e3 = horzcat(index, e(3, :).');
e4 = horzcat(index, e(4, :).');
e5 = horzcat(index, e(5, :).');
e6 = horzcat(index, e(6, :).');
e7 = horzcat(index, e(7, :).');
e8 = horzcat(index, e(8, :).');

f1 = horzcat(index, f(1, :).');
f2 = horzcat(index, f(2, :).');
f3 = horzcat(index, f(3, :).');
f4 = horzcat(index, f(4, :).');
f5 = horzcat(index, f(5, :).');
f6 = horzcat(index, f(6, :).');
f7 = horzcat(index, f(7, :).');
f8 = horzcat(index, f(8, :).');

g1 = horzcat(index, g(1, :).');
g2 = horzcat(index, g(2, :).');
g3 = horzcat(index, g(3, :).');
g4 = horzcat(index, g(4, :).');
g5 = horzcat(index, g(5, :).');
g6 = horzcat(index, g(6, :).');
g7 = horzcat(index, g(7, :).');
g8 = horzcat(index, g(8, :).');

h1 = horzcat(index, h(1, :).');
h2 = horzcat(index, h(2, :).');
h3 = horzcat(index, h(3, :).');
h4 = horzcat(index, h(4, :).');
h5 = horzcat(index, h(5, :).');
h6 = horzcat(index, h(6, :).');
h7 = horzcat(index, h(7, :).');
h8 = horzcat(index, h(8, :).');

I_out = [];

% out = sim("tuned_filter.slx", 1040);
out = sim("approx_adders.slx", 1040);

counter = 9;

for j = 0 : (dimensions(1) / 8)-1

    row = [];
    rowu = [];

    for i = 0 : (dimensions(2) / 8)-1     

        a0 = [out.simout(counter), out.simout1(counter), out.simout2(counter), out.simout3(counter), out.simout4(counter), out.simout5(counter), out.simout6(counter), out.simout7(counter)];
        b0 = [out.simout8(counter), out.simout9(counter), out.simout10(counter), out.simout11(counter), out.simout12(counter), out.simout13(counter), out.simout14(counter), out.simout15(counter)];
        c0 = [out.simout16(counter), out.simout17(counter), out.simout18(counter), out.simout19(counter), out.simout20(counter), out.simout21(counter), out.simout22(counter), out.simout23(counter)];
        d0 = [out.simout24(counter), out.simout25(counter), out.simout26(counter), out.simout27(counter), out.simout28(counter), out.simout29(counter), out.simout30(counter), out.simout31(counter)];
        e0 = [out.simout32(counter), out.simout33(counter), out.simout34(counter), out.simout35(counter), out.simout36(counter), out.simout37(counter), out.simout38(counter), out.simout39(counter)];
        f0 = [out.simout40(counter), out.simout41(counter), out.simout42(counter), out.simout43(counter), out.simout44(counter), out.simout45(counter), out.simout46(counter), out.simout47(counter)];
        g0 = [out.simout48(counter), out.simout49(counter), out.simout50(counter), out.simout51(counter), out.simout52(counter), out.simout53(counter), out.simout54(counter), out.simout55(counter)];
        h0 = [out.simout56(counter), out.simout57(counter), out.simout58(counter), out.simout59(counter), out.simout60(counter), out.simout61(counter), out.simout62(counter), out.simout63(counter)];

        counter = counter + 1;

        im_out = vertcat(a0, b0, c0, d0, e0, f0, g0, h0);
        im = Diag*im_out*Diag';

        row = horzcat(row, im);

    end

    I_out = vertcat(I_out, row);
end

%%


errors = return_metric(I_out, I_org, mask_1, T_m);

fprintf('MSE: %f    PSNR: %f\n', errors(1), errors(2));

    

    %%
% invdcta = @(block_struct) T_m' * block_struct.data * T_m;  %Inverse DCT function
% % figure(1)
% % imshow(I_org)
% 
% % figure(2)
% I_th = blockproc(I_out,[8 8],@(block_struct) mask_1 .* block_struct.data);  % Thersholding for each segment
% I_recon = blockproc(I_th,[8 8],invdcta); %Inverse DCT Operation for each segment
% imshow(I_recon);
% 
% %%
% 
% bits = 1:16
% figure(1);
% plot(bits, mses);
% title('Comparison of MSE for differing bit lengths');
% ylabel('MSE')
% xlabel('Bits')

%%

