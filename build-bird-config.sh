#!/bin/bash
set -e

SERVER=$1
CONFIG_DIR="$2/$SERVER"
ansible-role routing-policy $SERVER --connection=local -e bird_config_dir=$CONFIG_DIR
