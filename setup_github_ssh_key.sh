#!/bin/bash

if [ $# -ne 2 ]
then
	echo "provide github username[1] and email[2]"
	exit 1
fi

identity_file=~/.ssh/github_ssh_key_for_$1

mkdir -p ~/.ssh
ssh-keygen -t ed25519 -C "$2" -f "$identity_file"

echo "\
Host github.com
    User git
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile $identity_file"\
>> ~/.ssh/config

cat $identity_file.pub
chmod 400 $identity_file
