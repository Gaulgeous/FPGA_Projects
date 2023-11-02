
% CSSE4010 - Digital System Design - Practical 5
% Supporting Matlab file for practical 5

% This Matlab script provides two-tone input signal and FIR filter
% coefficients and also defines parameters for Xilinx System
% Generator/Model compose
% implementation of the FIR filter.


clear all; close all; clc;
%create two tone input signal.

%A1,A2 are the amplitude of the signals
%f1,f2 are the frequency of the signals (Hz)
%fs  sampling frequency (Hz)
%duration in seconds
%cycle no of cycles
A1=1;
A2=4;
f1=200;
f2=2000;
fs=8000; 
dur=1/4;
cycle=5;

values=0:1/fs:(dur-1/fs);
sig1=A1*sin(2*pi* f1*values);
sig2=A2*sin(2*pi* f2*values);
sigtemp=[sig1';sig2']';
sig=[];

for i=1:cycle
    sig=[sig';sigtemp']';
end
sig=sig'; %sig is the input signal to the filter

max_in = max(sig);
min_in = min(sig);

%get filter coefficients
Wo=0.15; %normalized cut off frequency 0<W0<1;
taps=16; % order of the FIR filter
[b]=fir1(taps,Wo,'low'); %Low pass filter
freqz(b,1,512);% Plot filter responses with 512 fft points
filtered_signal_sw=filter(b,1,sig); %filter the signal

max_out = max(filtered_signal_sw);
min_out = min(filtered_signal_sw);

%soundsc(sig,fs); %Play orginal
%soundsc(filtered_signal_sw,fs); %Play filtered

%%
% Parameters for the System Generator Design
LH=length(sig);
sig_in=zeros(LH,2);
sig_in(:,1)=1:LH;
sig_in(:,2)=sig; % This is the input signa to the System Generator Model

% Fixed-point word lengths for signal
W=4;
D=12;

% Fixed-point word lengths for filter coefficients
Wc=1;
Dc=7;

% After setting these up you can run the Simulink model with System
% Generator design and this will provide the filtered output. You can then
% compare the output with the software version above to verify the correct
% functionality and also to fine-tune the wordlengths

untuned_out = sim("untuned_filter.slx");
untuned_response = untuned_out.simout;
% 
% tuned_out = sim("tuned_filter.slx");
% tuned_response = tuned_out.simout;

% figure
% plot(filtered_signal_sw); hold on; plot(untuned_response); legend('Software','Untuned');
% title('Comparison between Software and Untuned Signal')
% xlabel('Time');
% ylabel('Amplitude');
% 
% x = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
% y = [-4.06, -7.896, -9.14, -10.058, -10.069, -10.06, -10.06, -10.06, -10.06, -10.06, -10.06, -10.06, -10.06];
% figure
% plot(x, errors); 
% title('Relationship Between SER and Increasing Input Bit Granularity')
% xlabel('Bits');
% ylabel('SER (Db)');

% errors = [];

% for n=1: 12
%     D = n;
%     untuned_out = sim("untuned_filter.slx");
%     untuned_response = untuned_out.simout;
%     
%     hw_refined = untuned_response(6:end);
%     sw_refined = filtered_signal_sw(1:end-4);
%     
%     error = hw_refined - sw_refined;
%     error_p = sum(error.^2);
%     orig_p = sum(sw_refined.^2);
% 
%     ser = 10*log10(error_p/orig_p);
%     
%     errors(end + 1) = ser;
% end




% bit_sizes = [8, 16, 32, 64];
% wcs = [1, 4];
% 
% for n = 1 : length(bit_sizes)
%     for wc = 1 : length(wcs)
%         D = bit_sizes(N) - W;
%         Dc = bit_sizes(N) - wc;
%         
%         untuned_out = sim("untuned_filter.slx");
%         untuned_response = untuned_out.simout;
% 
%         tuned_out = sim("tuned_filter.slx");
%         tuned_response = tuned_out.simout;
% 
%     end
% end




