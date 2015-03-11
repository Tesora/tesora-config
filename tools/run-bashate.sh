#!/bin/bash

ROOT=$(readlink -fn $(dirname $0)/.. )
# BH: TODO: We should not be ignoring errors here.  But, these errors are all in the upstream code.  revisit
find $ROOT -not -wholename \*.tox/\* -and \( -name \*.sh -or -name \*rc -or -name functions\* \) -print0 | xargs -0 bashate -v --ignore E003,E001,E002,E020,E004,E011,E010
