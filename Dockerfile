# Use the official Android SDK Docker image as the base image                                                                     
FROM androidsdk/android-30                                                                                                        
# Download and install prebuilt scrcpy binary

# Install dependencies for NoVNC, X11, and scrcpy
# Install build tools for scrcpy
RUN apt-get update && apt-get install -y \
    git \
    meson \
    ninja-build \
    pkg-config \
    ffmpeg \
    libsdl2-2.0-0 \
    libsdl2-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libusb-1.0-0-dev \
    adb \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Genymobile/scrcpy/releases/download/v3.2/scrcpy-linux-x86_64-v3.2.tar.gz && \
    tar -xzf scrcpy-linux-x86_64-v3.2.tar.gz && \
    cp -r scrcpy-linux-x86_64-v3.2/* /usr/local/ && \
    rm -rf scrcpy-linux-x86_64-v3.2 scrcpy-linux-x86_64-v3.2.tar.gz
   

# Install latest Meson via pip (overrides the old one)

# Set environment variables for Android SDK
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin

# Install Android platform tools and Android 30 image
RUN sdkmanager "platform-tools" "platforms;android-30" "system-images;android-30;google_apis;x86_64" "emulator"

# Create directory for NoVNC and VNC setup
RUN mkdir -p /root/.vnc

# Expose VNC port and ADB port
EXPOSE 5901 5555

# Set up a script to start the VNC server and emulator
COPY start-emulator.sh /start-emulator.sh
RUN chmod +x /start-emulator.sh
# Add the PPA repository for scrcpy
# Add the PPA repository for scrcpy
# Default command to run emulator and start VNC
CMD ["/start-emulator.sh"]