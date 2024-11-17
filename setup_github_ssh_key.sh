#!/bin/bash

if [ $# -ne 2 ]
then
    echo "provide username[1] (only needed to name the file), email[2] (important) and host[3] (important. host example: github, bitbucket, etc)"
	exit 1
fi

username=$1
email=$2
host=$3

identity_file=~/.ssh/$(host)_ssh_key_for_$(username)

mkdir -p ~/.ssh
ssh-keygen -t ed25519 -C "$email" -f "$identity_file"

echo "\
Host github.com
    User git
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile $identity_file"\
>> ~/.ssh/config

cat $identity_file.pub
chmod 400 $identity_file
