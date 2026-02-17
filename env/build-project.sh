# Set up Android SDK and build the project
echo 'export ANDROID_HOME="${HOME}/Android/Sdk" ' >>  ~/.bashrc 
echo 'export PATH="${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${PATH}" ' >>  ~/.bashrc 

# Set up Android SDK
mkdir -p "${HOME}/Android/Sdk"
cd "${ANDROID_HOME}"
cd ..
wget "https://edgedl.me.gvt1.com/android/studio/ide-zips/2025.3.1.8/android-studio-panda1-patch1-linux.tar.gz"
tar -xvzf android-studio-panda1-patch1-linux.tar.gz 
rm -rf android-studio-panda1-patch1-linux.tar.gz 
rm -rf Sdk/
mv android-studio Sdk/

# Set up command line tools
cd "${ANDROID_HOME}"
cd ..
wget "https://dl.google.com/android/repository/commandlinetools-linux-14742923_latest.zip"
unzip commandlinetools-linux-14742923_latest.zip 
rm -rf commandlinetools-linux-14742923_latest.zip 
mv cmdline-tools/ latest
mkdir -p Sdk/cmdline-tools
mv latest Sdk/cmdline-tools/latest

# Accept licenses
cd "${ANDROID_HOME}/cmdline-tools/bin/"
yes y | ./sdkmanager --licenses 

# Install required SDK components
curl -s "https://get.sdkman.io" | bash
sdk install gradle 8.13 
sdk install kotlin 1.8.20
sdk install groovy 3.0.25
sdk install java 17.0.18-ms 

# Build the project
cd "/workspaces/${PROJECT_NAME}/"
chmod +x gradlew
./gradlew assembleRelease --stacktrace
