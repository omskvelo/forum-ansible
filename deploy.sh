#!/bin/bash -ex

./requirements/install.sh

ansible-playbook -i hosts.ini --ask-become-pass deploy.yaml $@
