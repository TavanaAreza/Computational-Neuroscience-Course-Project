%% Ahmadreza Tavana               98104852

%% ======================= Final Project =======================


%% ======================= Question 2: Neurons And Input Currents =======================
clear; clc; close all;

t = 1:200;
I1 = exp(-(t-10)/0.25).*(10<=t).*(t<15)+exp(-(t-40)/0.25).*(40<=t).*(t<45)+exp(-(t-110)/0.25).*(110<=t).*(t<115);
I2 = 0.2*(exp(-(t-20)/0.25).*(20<=t).*(t<25)+exp(-(t-80)/0.25).*(80<=t).*(t<85)+exp(-(t-150)/0.25).*(150<=t).*(t<155));
I3 = 0.3*(exp(-(t-30)/0.25).*(30<=t).*(t<35)+exp(-(t-70)/0.25).*(70<=t).*(t<75)+exp(-(t-160)/0.25).*(160<=t).*(t<165));
I4 = 0.6*(exp(-(t-25)/0.25).*(25<=t).*(t<30)+exp(-(t-55)/0.25).*(55<=t).*(t<60)+exp(-(t-110)/0.25).*(110<=t).*(t<115));
I5 = 0.1*(exp(-(t-10)/0.25).*(10<=t).*(t<15)+exp(-(t-30)/0.25).*(30<=t).*(t<35)+exp(-(t-120)/0.25).*(120<=t).*(t<125));
Ks = 4*exp(-4*(t));


%% =========== Part 1 ===========
clc;

wb = [1.5, 3, -0.5, 2, 1.5];
Is =0;

Is = Is + wb(1)*conv(Ks, I1);
Is = Is + wb(2)*conv(Ks, I2);
Is = Is + wb(3)*conv(Ks, I3);
Is = Is + wb(4)*conv(Ks, I4);
Is = Is + wb(5)*conv(Ks, I5);

Is = Is(1:length(t));

figure()
plot(t, Is, 'LineWidth', 1.5)
grid on
xlabel('Time', 'interpreter', 'latex')
ylabel('Amplitude', 'interpreter', 'latex')

%% =========== Part 2 ===========
clc;

w = zeros(5, 1);
epochs = 20;
w_epoch = zeros(5, epochs+1);
len = length(Is);
epsilon = 0.3;
count = -1;

for epoch = 1:epochs
    for i = 1:len
        r = Is(i);
        I = [I1(i), I2(i), I3(i), I4(i), I5(i)]';
        v = (w')*I;
        delta = r - v;
        w = w + delta*epsilon*u(I);   
    end
    w_epoch(:, epoch+1) = w;
end

figure()
hold on
LineWidth = 1.3; 
plot(w_epoch(1, :), 'LineWidth', LineWidth)
plot(w_epoch(2, :), 'LineWidth', LineWidth)
plot(w_epoch(3, :), 'LineWidth', LineWidth)
plot(w_epoch(4, :), 'LineWidth', LineWidth)
plot(w_epoch(5, :), 'LineWidth', LineWidth)
title('Plot of vlues of weights during the learning process', 'interpreter', 'latex')
xlabel('Epoch', 'interpreter', 'latex')
ylabel('Value',  'interpreter', 'latex')
legend('W1', 'W2', 'W3', 'W4', 'W5')
grid minor


v = zeros(1, len);
for i = 1:len
    I = [I1(i), I2(i), I3(i), I4(i), I5(i)]';
    v(i) = (w')*I;
end

figure()
hold on
plot(t, v, 'LineWidth', 1.5);
title('Output of the network for input currents', 'interpreter', 'latex')
xlabel('Time', 'interpreter', 'latex')
ylabel('Amplitude',  'interpreter', 'latex')
grid on


%% =========== Part 3 ===========
clc; 

Is =0;

Is = Is + w(1)*conv(Ks, I1);
Is = Is + w(2)*conv(Ks, I2);
Is = Is + w(3)*conv(Ks, I3);
Is = Is + w(4)*conv(Ks, I4);
Is = Is + w(5)*conv(Ks, I5);

Is = Is(1:length(t));

figure()
plot(t, Is, 'LineWidth', 1.5)
grid on
xlabel('Time', 'interpreter', 'latex')
ylabel('Amplitude', 'interpreter', 'latex')


%% ======================= Functions =======================

function y = u(x)
    y = zeros(length(x), 1);
    idx = find( x ~= 0);
    y(idx) = 1;
end


