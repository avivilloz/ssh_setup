#!/bin/bash

if [ $# -ne 3 ]
then
    echo "provide keylabel[1] (only needed to name the file), email[2] (important) and host[3] (important. host example: github.com, bitbucket.org, etc)"
	exit 1
fi

keylabel=$1
email=$2
host=$3

identity_file="~/.ssh/$keylabel"

mkdir -p ~/.ssh
ssh-keygen -t ed25519 -C "$email" -f "$identity_file"

echo "\
Host $host
    User git
    HostName $host
    PreferredAuthentications publickey
    IdentityFile $identity_file"\
>> ~/.ssh/config

cat $identity_file.pub
chmod 400 $identity_file
