#!/bin/bash

pushd $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) >/dev/null

ansible-galaxy install -r requirements.yml

popd >/dev/null
