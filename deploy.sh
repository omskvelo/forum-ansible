#!/bin/bash -ex

./requirements_install.sh

ansible-playbook -i hosts.ini --ask-become-pass deploy.yaml $@
