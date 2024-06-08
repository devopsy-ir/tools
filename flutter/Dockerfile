#FROM openjdk:8-slim-stretch
#RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

FROM openjdk:11-slim-bullseye

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get install -yq libc6 libstdc++6 zlib1g libncurses5 build-essential libssl-dev ruby ruby-dev --no-install-recommends wget unzip git curl && \
    apt-get clean
    
RUN gem install bundler -v '1.16.1'

# Download and untar Android SDK tools
#RUN mkdir -p /usr/local/android-sdk-linux && \
#    wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O tools.zip && \
#    unzip tools.zip -d /usr/local/android-sdk-linux && \
#    rm tools.zip

RUN mkdir -p /usr/local/android-sdk-linux && \
    wget --quiet --output-document=tools.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip && \
  unzip tools.zip -d /usr/local/android-sdk-linux && \
  rm -rf tools.zip && mv /usr/local/android-sdk-linux/cmdline-tools /usr/local/android-sdk-linux/tools

# Set environment variable
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

RUN $ANDROID_HOME/tools/bin/sdkmanager --sdk_root=${ANDROID_HOME}/tools --licenses
# Make license agreement
RUN mkdir $ANDROID_HOME/licenses && \
    echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > $ANDROID_HOME/licenses/android-sdk-license && \
    echo d56f5187479451eabf01fb78af6dfcb131a6481e >> $ANDROID_HOME/licenses/android-sdk-license && \
    echo 24333f8a63b6825ea9c5514f83c2829b004d1fee >> $ANDROID_HOME/licenses/android-sdk-license && \
    echo 84831b9409646a918e30573bab4c9c91346d8abd > $ANDROID_HOME/licenses/android-sdk-preview-license

# Update and install using sdkmanager
RUN $ANDROID_HOME/tools/bin/sdkmanager --sdk_root=${ANDROID_HOME}/tools "tools" "platform-tools" && \
    $ANDROID_HOME/tools/bin/sdkmanager --sdk_root=${ANDROID_HOME}/tools "build-tools;33.0.1" "build-tools;33.0.1" && \
    $ANDROID_HOME/tools/bin/sdkmanager --sdk_root=${ANDROID_HOME}/tools "platforms;android-33" "platforms;android-33" && \
    $ANDROID_HOME/tools/bin/sdkmanager --sdk_root=${ANDROID_HOME}/tools "extras;android;m2repository" "extras;google;m2repository"

# define variables
ARG FLUTTER_SDK=/usr/local/flutter
ARG FLUTTER_VERSION=3.10.5
ARG APP=/app/

#clone flutter
RUN git clone https://github.com/flutter/flutter.git $FLUTTER_SDK
# change dir to current flutter folder and make a checkout to the specific version
RUN cd $FLUTTER_SDK && git fetch && git checkout $FLUTTER_VERSION

# setup the flutter path as an enviromental variable
ENV PATH="$FLUTTER_SDK/bin:$FLUTTER_SDK/bin/cache/dart-sdk/bin:${PATH}"

# Start to run Flutter commands
# doctor to see if all was installes ok
RUN flutter doctor -v

# create folder to copy source code
RUN mkdir $APP
# copy source code to folder
COPY . $APP
# stup new folder as the working directory
WORKDIR $APP

RUN cd android && echo "org.gradle.daemon=false" >> ./gradle.properties && ./gradlew clean

RUN sed -r 's#storeFile(.*)#storeFile=/app/key_frotel.jks#g' android/key.properties -i

RUN sed -r "s/ext.kotlin_version(.*)/ext.kotlin_version = '2.0.0'/g" android/build.gradle -i

RUN rm -rf android/.gradle

RUN rm -rf ~/.gradle/caches

# Run build: 1 - clean, 2 - pub get, 3 - build web
RUN flutter clean

RUN flutter pub get

#RUN flutter build web

RUN flutter build apk --release --split-per-abi --no-tree-shake-icons
