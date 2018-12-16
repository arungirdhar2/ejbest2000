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

  if [ ! $lastVal = 1 ]
  then
    echo $1
    echo "Cannot uninstall requirement fabric, not installed:  \"$1\""
    echo "File \"$0\", line $lineno"    # Give name of file and line number.
    exit $E_ASSERT_FAILED
  # else
  #   return
  #   and continue executing the script.
  fi

} # Insert a similar assert() function into a script you need to debug.    
#######################################################################

#assert "sudo apt --assume-yes remove python3-pip" $LINENO
pip3 uninstall fabric
pip3 uninstall selenium
sudo rm -rf temp
sudo apt --assume-yes remove python3-pip
#sudo apt-get update
#assert "sudo apt-get --assume-yes install -y libappindicator1 fonts-liberation" $LINENO
#assert "mkdir temp" $LINENO
#assert "cd temp" $LINENO
#assert "wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" $LINENO
#sudo dpkg -i google-chrome*.deb
#assert "sudo apt-get -f --assume-yes install" $LINENO
#assert "sudo dpkg --configure -a" $LINENO
#assert "cd .." $LINENO
#assert "sudo chmod +x chromedriver" $LINENO
#assert "sudo rm -rf temp" $LINENO
 The remainder of the script executes only if the "assert" does not fail.

echo "This statement echoes only if the \"assert\" does not fail."
exit $?
