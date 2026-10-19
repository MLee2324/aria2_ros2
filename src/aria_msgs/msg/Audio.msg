# One block of microphone samples from the glasses.
# header.stamp is the host time of the first sample.
std_msgs/Header header

# Samples per second per channel, measured from the device timestamps.
uint32 sample_rate
uint8 channels

# Interleaved signed 32-bit samples, length samples * channels.
int32[] data
