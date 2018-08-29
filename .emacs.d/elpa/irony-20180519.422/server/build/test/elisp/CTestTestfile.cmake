# CMake generated Testfile for 
# Source directory: /Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/test/elisp
# Build directory: /Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/build/test/elisp
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(check-irony-el "/Applications/emacs.app/Contents/MacOS/Emacs" "-Q" "--batch" "-l" "package" "--eval" "(package-initialize)" "--eval" "(unless (require 'cl-lib nil t) (package-refresh-contents) (package-install 'cl-lib))" "-l" "/Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/test/elisp/irony.el" "-f" "ert-run-tests-batch-and-exit")
set_tests_properties(check-irony-el PROPERTIES  TIMEOUT "15")
add_test(check-irony-iotask-el "/Applications/emacs.app/Contents/MacOS/Emacs" "-Q" "--batch" "-l" "package" "--eval" "(package-initialize)" "--eval" "(unless (require 'cl-lib nil t) (package-refresh-contents) (package-install 'cl-lib))" "-l" "/Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/test/elisp/irony-iotask.el" "-f" "ert-run-tests-batch-and-exit")
set_tests_properties(check-irony-iotask-el PROPERTIES  TIMEOUT "15")
add_test(check-irony-cdb-json-el "/Applications/emacs.app/Contents/MacOS/Emacs" "-Q" "--batch" "-l" "package" "--eval" "(package-initialize)" "--eval" "(unless (require 'cl-lib nil t) (package-refresh-contents) (package-install 'cl-lib))" "-l" "/Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/test/elisp/irony-cdb-json.el" "-f" "ert-run-tests-batch-and-exit")
set_tests_properties(check-irony-cdb-json-el PROPERTIES  TIMEOUT "15")
