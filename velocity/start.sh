#!/bin/bash

VELOCITY=(velocity-proxy-*-all.jar)
if [[ -z "${VELOCITY}" ]]; then
    echo "Downloading latest Velocity"
    mkdir -p /tmp/velocity
    wget -qO /tmp/velocity.zip https://ci.velocitypowered.com/job/velocity/lastSuccessfulBuild/artifact/*zip*/archive.zip
    unzip -qd /tmp/velocity /tmp/velocity.zip
    find /tmp/velocity -name velocity-proxy-*-all.jar -exec cp {} . \;
    rm -rf /tmp/velocity*
    VELOCITY=(velocity-proxy-*-all.jar)
fi
if [[ -z "${VELOCITY}" ]]; then
    echo "Could not find Velocity launcher $VELOCITY"
    exit 1;
fi

[[ $(uname -s) = "Linux" ]] && DELIMITER=":" || DELIMITER=";"
CLASSPATH=$(find classpath/ -type f 2>/dev/null | paste -s -d ${DELIMITER})
[[ ! -z ${CLASSPATH} ]] && CLASSPATH=${DELIMITER}${CLASSPATH}

umask -S u=rwx,g=rwx
exec java "$@" -Xms${MEMORY}M -Xmx${MEMORY}M \
    -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap \
    -cp "${VELOCITY}${CLASSPATH}" com.velocitypowered.proxy.Velocity
