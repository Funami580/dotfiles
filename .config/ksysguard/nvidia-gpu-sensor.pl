#!/usr/bin/perl -w

# Stolen from: https://gist.github.com/Sporif/4ce63f7b6eea691bdbb18905a9589169
# act as a KSysGuard sensor
# provides NVIDIA GPU info via `nvidia-smi`

# Usage:
# 1. Save this script, make it executable and move it to a directory in your $PATH
# 2. Save this ksysguard sensor file for Nvidia: https://gist.github.com/Sporif/31f0d8d9efc3315752aa4031f7080d79
# 2. In KSysGuard's menu, open "File > Import Tab From File option"
# 3. Open the sensor file (nvidia.srgd)

# See Also
# https://techbase.kde.org/Development/Tutorials/Sensors

$|=1;

print "ksysguardd 1.2.0\n";
print "ksysguardd> ";

system 'lsmod | grep -q nvidia';
$no_nvidia = 1 if $?;

while(<>){
    if(/monitors/){
        print "gpu_temp\tinteger\n";
        print "gpu_fan_speed\tinteger\n";
        print "gpu_core_usage\tinteger\n";
        print "gpu_core_clock\tinteger\n";
        print "gpu_mem_mib\tinteger\n";
        print "gpu_mem_clock\tinteger\n";
        print "gpu_video_decode\tinteger\n";
        print "gpu_video_encode\tinteger\n";
    }
    if(/gpu_temp/){
        if(/\?/){
            print "GPU Temp\t0\t100\t°C\n";
        }else{
            print `nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader` unless $no_nvidia;
        }
    }
    if(/gpu_fan_speed/){
        if(/\?/){
            print "GPU Fan Speed\t0\t100\t%\n";
        }else{
            print `nvidia-smi --query-gpu=fan.speed --format=csv,noheader,nounits` unless $no_nvidia;
        }
    }
    if(/gpu_core_usage/){
        if(/\?/){
            print "GPU Core Usage\t0\t100\t%\n";
        }else{
            print `nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits` unless $no_nvidia;
        }
    }
    if(/gpu_core_clock/){
        if(/\?/){
            print "GPU Core Clock\t0\t2500\tMhz\n";
        }else{
            print `nvidia-smi --query-gpu=clocks.current.graphics --format=csv,noheader,nounits` unless $no_nvidia;
        }
    }
    if(/gpu_mem_mib/){
        if(/\?/){
            print "GPU Memory Usage\t0\t".`lsmod | grep -q nvidia && nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | perl -pe 'chomp'`."\tMiB\n";
        }else{
            print `nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits` unless $no_nvidia;
        }
    }
    if(/gpu_mem_clock/){
        if(/\?/){
            print "GPU Memory Clock\t0\t8000\tMhz\n";
        }else{
            print `nvidia-smi --query-gpu=clocks.current.memory --format=csv,noheader,nounits` unless $no_nvidia;
        }
    }
    if(/gpu_video_decode/){
        if(/\?/){
            print "GPU Decoding\t0\t100\t%\n";
        }else{
            print `nvidia-smi dmon -c 1 -s u | sed s/#// | awk '{print \$5}' | tail -n 1` unless $no_nvidia;
        }
    }
    if(/gpu_video_encode/){
        if(/\?/){
            print "GPU Encoding\t0\t100\t%\n";
        }else{
            print `nvidia-smi dmon -c 1 -s u | sed s/#// | awk '{print \$4}' | tail -n 1` unless $no_nvidia;
        }
    }
    print "ksysguardd> ";
}