#!/bin/bash -ex

ansible-playbook -i hosts.ini --ask-become-pass deploy.yaml $@
