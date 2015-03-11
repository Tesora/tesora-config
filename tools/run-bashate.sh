#!/bin/bash

ROOT=$(readlink -fn $(dirname $0)/.. )
find $ROOT -not -wholename \*.tox/\* -and \( -name \*.sh -or -name \*rc -or -name functions\* \) -print0 | xargs -0 bashate -v 

# BH: if we wanted this to be passing, one approach to ignoring all these:
# find $ROOT -not -wholename \*.tox/\* -and \( -name \*.sh -or -name \*rc -or -name functions\* \) -print0 | xargs -0 bashate -v --ignore E003,E001,E002,E020,E004,E011,E010
