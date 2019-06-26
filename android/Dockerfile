ARG     VERSION=28.0.3
FROM	golang:1.12.0-alpine3.9 as golang
RUN     apk add --no-cache --update git && \
        GOOS=linux GOARCH=amd64 go get github.com/stevenmatthewt/semantics github.com/tcnksm/ghr

FROM    frolvlad/alpine-glibc:alpine-3.9_glibc-2.29
RUN     apk add --no-cache --update git openjdk8 curl nss bash ruby-bundler openssh-client alpine-sdk ruby-dev
COPY    --from=golang /go/bin/semantics /go/bin/ghr /usr/local/bin/

ARG     sdk_zip=sdk-tools-linux-4333796.zip
ARG     android_home=/opt/android/sdk

RUN     mkdir -p ${android_home} && \
        curl --silent --show-error --location --fail --retry 3 --output /tmp/${sdk_zip} https://dl.google.com/android/repository/${sdk_zip} && \
        unzip -q /tmp/${sdk_zip} -d ${android_home} && \
        rm /tmp/${sdk_zip}

ENV     ANDROID_HOME ${android_home}
ENV     ADB_INSTALL_TIMEOUT 120
ENV     PATH=${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

# Update SDK manager and install system image, platform and build tools
RUN     mkdir ~/.android && \
        echo '### User Sources for Android SDK Manager' > ~/.android/repositories.cfg && \
        yes | sdkmanager --licenses && \
        yes | sdkmanager --update && \
        sdkmanager "tools" "platform-tools" "emulator" "build-tools;28.0.3" "platforms;android-28"