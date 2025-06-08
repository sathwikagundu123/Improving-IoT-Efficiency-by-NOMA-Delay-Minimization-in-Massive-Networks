clc;
clear;
close all;

% Parameters
iterations = 50;
initial_delay = 10; % ms
initial_bit_rate = 1; % Mbps
delay_reduction_factor = 0.95;
bitrate_reduction_factor = 0.98;

delay = zeros(1, iterations);
bit_rate = zeros(1, iterations);
operating_period = zeros(1, iterations);
interference = zeros(1, iterations);

% Main Delay Minimization Loop
for i = 1:iterations
    delay(i) = initial_delay * (delay_reduction_factor ^ i);
    bit_rate(i) = initial_bit_rate * (bitrate_reduction_factor ^ i);
    operating_period(i) = delay(i) * bit_rate(i);
    interference(i) = rand() * 2; % Random interference (0 to 2)
end

% Plot 1: Operating Period vs Iterations
figure;
plot(1:iterations, operating_period, '-o', 'LineWidth', 2);
xlabel('Iterations');
ylabel('Operating Period (ms*Mbps)');
title('Operating Period vs Iterations');
grid on;

% Plot 2: Total Interference vs Iterations
figure;
plot(1:iterations, interference, '-s', 'LineWidth', 2, 'Color', 'r');
xlabel('Iterations');
ylabel('Total Interference');
title('Total Interference vs Iterations');
grid on;

% Additional Plots
% Number of Devices vs Average Operating Period
devices = 10:10:100;
avg_operating_period = operating_period(end) ./ devices;

figure;
plot(devices, avg_operating_period, '-x', 'LineWidth', 2, 'Color', 'm');
xlabel('Number of Devices');
ylabel('Avg Operating Period');
title('Avg Operating Period vs Number of Devices');
grid on;

% Transmission Power vs Avg Operating Period
transmit_power = 0.1:0.1:1.0;
avg_op_period_power = operating_period(end) ./ (2 * transmit_power); % simple scaling

figure;
plot(transmit_power, avg_op_period_power, '-^', 'LineWidth', 2, 'Color', 'g');
xlabel('Max Transmission Power (Watts)');
ylabel('Avg Operating Period');
title('Avg Operating Period vs Transmission Power');
grid on;

% Traffic Volume vs Avg Operating Period
traffic_volumes = 0:10:100;
avg_op_period_traffic = operating_period(end) * (1 + 0.01 * traffic_volumes); % delay increases slightly

figure;
plot(traffic_volumes, avg_op_period_traffic, '-*', 'LineWidth', 2, 'Color', 'b');
xlabel('Traffic Volume');
ylabel('Avg Operating Period');
title('Avg Operating Period vs Traffic Volume');
grid on;
