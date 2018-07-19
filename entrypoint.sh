#!/usr/bin/dumb-init /bin/sh

uid=${FLUENT_UID:0}

# check if a old fluent user exists and delete it
cat /etc/passwd | grep fluent
if [ $? -eq 0 ]; then
    deluser fluent
fi

# (re)add the fluent user with $FLUENT_UID
adduser -D -g '' -u ${uid} -h /home/fluent fluent

# chown home and data folder
chown -R fluent /home/fluent
chown -R fluent /fluentd
exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT