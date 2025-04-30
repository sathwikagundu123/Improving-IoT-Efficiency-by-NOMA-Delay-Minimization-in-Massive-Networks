# Improving-IoT-Efficiency-by-NOMA-Delay-Minimization-in-Massive-Networks

In this project, we focused on solving a key challenge in IoT systems — that is, how to reduce communication delay when there are a large number of devices.

We used Non-Orthogonal Multiple Access (NOMA) combined with dynamic user scheduling and adaptive power control, and implemented the simulation using MATLAB.

Our simulation shows that by intelligently selecting which devices to transmit and adjusting their transmission power based on channel quality, we can rapidly reduce the average delay, stabilize device queues, and efficiently manage power.

The graphs clearly show that delay decreases sharply in the first few iterations, queues remain under control, and throughput remains strong even as the number of devices increases — proving the scalability and efficiency of the system

✅ NOMA + Dynamic Scheduling reduces delay.

✅ NOMA improves throughput (total data transmitted).

✅ NOMA efficiently uses transmission power even with many devices.

✅ NOMA manages queue lengths (meaning no device waits too long).

>> It models a large IoT network (up to 200 devices, scalable to 500).

>> It implements key ideas of NOMA simulation:

>> Dynamic user scheduling (top 20% based on queue and channel conditions).

>> Adaptive power allocation (more power for bad channels — core NOMA principle).

>> Traffic handling (random traffic generation and queue updating).

>> Delay calculation (important for delay minimization).

>> Throughput and power usage monitoring (important IoT performance parameters).

>> It visualizes important graphs that are needed for analysis:

>> Delay vs Iterations

>> Queue evolution for random devices

>> Power usage vs Iterations

>> Throughput vs Number of Devices
