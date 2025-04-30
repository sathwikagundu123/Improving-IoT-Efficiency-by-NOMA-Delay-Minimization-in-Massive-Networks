clc;
clear;
close all;

% Step 1: Setup Environment
numDevices = 200;                 % Number of IoT devices
numIterations = 100;              % Number of simulation iterations
maxPower = 1;                     % Maximum transmission power (Watt)
queueSize = zeros(1, numDevices); % Initial queue size (MB)
trafficLoad = randi([1,5], 1, numDevices); % Initial random traffic (MB)
channelQuality = rand(1, numDevices); % Initial random channel quality [0-1]

% Storage Variables
avgDelay = zeros(1, numIterations);
totalThroughput = zeros(1, numIterations);
totalPowerUsed = zeros(1, numIterations);
queueEvolution = zeros(numIterations, 5); % Queue evolution of 5 random devices
selectedDevicesIndices = randperm(numDevices, 5); % Select 5 random devices for observation

% Step 2 & 3: Run Simulation Loop
for iter = 1:numIterations
    % Update Traffic and Channel Dynamically
    trafficLoad = randi([0,2], 1, numDevices);  % New burst traffic (0–2 MB)
    channelQuality = rand(1, numDevices);       % New random SNR

    % Priority Assignment
    priority = (queueSize + trafficLoad) ./ (channelQuality + 0.01);

    % Dynamic User Scheduling: Select Top 20% Users
    [~, sortedIndices] = sort(priority, 'descend');
    scheduledUsers = sortedIndices(1:round(0.2 * numDevices)); 

    % Adaptive Power Allocation
    powerAlloc = zeros(1, numDevices);
    powerAlloc(scheduledUsers) = maxPower * (1 - channelQuality(scheduledUsers));

    % Calculate Data Rate: using simplified Shannon formula
    dataRate = log2(1 + (powerAlloc .* channelQuality));  % in Mbps approx.

    % Update Queues and Delays
    servedData = dataRate * 0.1; % Assume transmission slot = 0.1s
    queueSize = max(queueSize + trafficLoad - servedData, 0);

    % Record Metrics
    avgDelay(iter) = mean(queueSize ./ (dataRate + 0.01)); % Average delay
    totalThroughput(iter) = sum(servedData);               % Total throughput
    totalPowerUsed(iter) = sum(powerAlloc);                 % Power usage

    % Record queue evolution for 5 random devices
    queueEvolution(iter, :) = queueSize(selectedDevicesIndices);
end

% Step 4: Plot Visualizations

% 📈 Visualization 1: Average Delay vs Iterations
figure;
plot(1:numIterations, avgDelay, 'LineWidth', 2, 'Color', 'b');
title('Average Delay vs Iterations');
xlabel('Iterations');
ylabel('Average Delay (ms)');
grid on;

%  Visualization 2: Queue Length Evolution (for 5 Devices)
figure;
plot(1:numIterations, queueEvolution, 'LineWidth', 1.5);
title('Queue Length Evolution for 5 Random Devices');
xlabel('Iterations');
ylabel('Queue Size (MB)');
legend('Device 1','Device 2','Device 3','Device 4','Device 5');
grid on;

% Visualization 3: Power Usage Distribution
figure;
plot(1:numIterations, totalPowerUsed, 'LineWidth', 2, 'Color', 'm');
title('Total Power Usage vs Iterations');
xlabel('Iterations');
ylabel('Power Used (Watt)');
grid on;

% Visualization 4: Throughput vs Number of Devices
deviceRange = 50:50:500; % Number of devices 50 to 500
throughputPerDevice = zeros(size(deviceRange));

for d = 1:length(deviceRange)
    % Re-run mini simulation for throughput testing
    devices = deviceRange(d);
    powerAlloc = maxPower * rand(1, devices);
    channelQuality = rand(1, devices);
    dataRate = log2(1 + (powerAlloc .* channelQuality));
    throughputPerDevice(d) = mean(dataRate);
end

figure;
bar(deviceRange, throughputPerDevice, 'FaceColor', [0.2 0.6 0.8]);
title('Average Throughput vs Number of Devices');
xlabel('Number of Devices');
ylabel('Throughput per Device (Mbps)');
grid on;



