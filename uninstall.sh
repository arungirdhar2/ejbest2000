#!/bin/bash
# assert.sh

#######################################################################
assert ()                 #  If condition false,
{                         #+ exit from script
                          #+ with appropriate error message.
  E_PARAM_ERR=98
  E_ASSERT_FAILED=99


  if [ -z "$2" ]          #  Not enough parameters passed
  then                    #+ to assert() function.
    return $E_PARAM_ERR   #  No damage done.
  fi

  lineno=$2
  testmenow=$1
  $testmenow
  lastVal=$?
  if [ ! $lastVal = 0 ]
  then
    echo $1
    echo "Assertion failed:  \"$1\""
    echo "File \"$0\", line $lineno"    # Give name of file and line number.
    exit $E_ASSERT_FAILED
  # else
  #   return
  #   and continue executing the script.
  fi

#  if [ ! $lastVal = 1 ]
#  then
#    echo $1
#    echo "Cannot uninstall requirement , already uninstalled:  \"$1\""
#    echo "File \"$0\", line $lineno"    # Give name of file and line number.
#
#  # else
#  #   return
#  #   and continue executing the script.
#  fi

} # Insert a similar assert() function into a script you need to debug.    
#######################################################################

#assert "sudo apt --assume-yes remove python3-pip" $LINENO
pip3 uninstall fabric
pip3 uninstall selenium
assert "sudo rm -rf temp" $LINENO
assert "sudo rm -rf __pycache__"

 The remainder of the script executes only if the "assert" does not fail.

echo "HURRAY !! This statement echoes only if the \"assert\" does not fail."
exit $?
