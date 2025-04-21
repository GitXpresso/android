#!/bin/bash
echo "no" | avdmanager create avd \
    --force \
    --name Pixel_3a_API_30_x86_64 \
    --device "pixel_3a" \
    --package "system-images;android-30;google_apis;x86_64" \
    --abi "x86_64"

# Start the Android emulator
echo "Starting Android Emulator..."
/opt/android-sdk/emulator/emulator -avd Pixel_3a_API_30_x86_64 -noaudio -no-boot-anim -gpu off &

# Start VNC server
echo "Starting VNC server..."
x11vnc -create -rfbport 5901 -nopw -forever -shared &

# Wait for the emulator to start
sleep 10

# Enable ADB connection
adb connect localhost:5555

# Run scrcpy to mirror the emulator screen
scrcpy