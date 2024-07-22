#!/bin/bash

## clear the screen at each logon
clear > /etc/issue
## Customize Logon message
cat >> /etc/issue << "EOF"
LFS 12.1 \n \l

EOF
