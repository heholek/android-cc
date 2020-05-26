FROM openjdk:8-jdk
MAINTAINER Paul Maddox <paul.maddox@gmail.com>

ENV ANDROID_COMPILE_SDK="29"        \
    ANDROID_BUILD_TOOLS="29.0.3"    \
    ANDROID_SDK_TOOLS_REV="4333796" \
    ANDROID_CMAKE_REV="3.6.4111459" \
    ANDROID_CMAKE_REV_3_10="3.10.2.4988404" \
    ANDROID_SDK_LOCATION="/opt/android-sdk-linux" \
    ANDROID_NDK_LOCATION="/opt/android-sdk-linux/ndk-bundle" 

ENV ANDROID_HOME=/opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/platform-tools/:${ANDROID_NDK_HOME}:${ANDROID_HOME}/ndk-bundle:${ANDROID_HOME}/tools/bin/:/usr/local/apache-maven-${MAVEN_VERSION}/bin

RUN apt-get update && \
    apt-get install -y file vim build-essential && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${ANDROID_HOME} \
    && wget --quiet --output-document=${ANDROID_HOME}/android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_REV}.zip \
    && unzip -qq ${ANDROID_HOME}/android-sdk.zip -d ${ANDROID_HOME} \
    && rm ${ANDROID_HOME}/android-sdk.zip \
    && mkdir -p $HOME/.android \
    && echo 'count=0' > $HOME/.android/repositories.cfg

RUN    yes | sdkmanager --licenses > /dev/null \ 
    && yes | sdkmanager --update \
    && yes | sdkmanager 'tools' \
    && yes | sdkmanager 'platform-tools' \
    && yes | sdkmanager 'build-tools;'$ANDROID_BUILD_TOOLS \
    && yes | sdkmanager 'platforms;android-'$ANDROID_COMPILE_SDK \
    && yes | sdkmanager 'extras;android;m2repository' \
    && yes | sdkmanager 'extras;google;google_play_services' \
    && yes | sdkmanager 'extras;google;m2repository' 

RUN    yes | sdkmanager 'cmake;'$ANDROID_CMAKE_REV \
       yes | sdkmanager --channel=3 --channel=1 'cmake;'$ANDROID_CMAKE_REV_3_10 \
    && yes | sdkmanager 'ndk-bundle' 

RUN mkdir -p /build
RUN mkdir -p /out

ADD env.sh /build/env.sh
ADD build-all.sh /build/build-all.sh 

RUN chmod 755 /build/*sh

CMD [ "/build/build-all.sh"]
