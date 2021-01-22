#! /bin/bash

cd .. \
&& git clone https://github.com/Mazoise/42TESTERS-GNL.git \
&& cd 42TESTERS-GNL \
&& ./all_tests.sh \
&& ./all_tests_with_bonus.sh