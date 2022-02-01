#!/bin/bash
# paywall


# [[file:../../../README.org::*paywall][paywall:1]]
set -ux
{ mkdir -p $HOME/dev && cd $HOME/dev && gh repo clone iamadamdev/bypass-paywalls-chrome; } || exit 0
# paywall:1 ends here
