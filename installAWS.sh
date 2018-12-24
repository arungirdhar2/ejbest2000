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
  if [ ! $? = 0 ]
  then
    echo $1
    echo "Assertion failed:  \"$1\""
    echo "File \"$0\", line $lineno"    # Give name of file and line number.
    exit $E_ASSERT_FAILED
  # else
  #   return
  #   and continue executing the script.
  fi
} # Insert a similar assert() function into a script you need to debug.
#######################################################################
assert "mkdir temp" $LINENO
assert "cd temp" $LINENO
assert "sudo yum-builddep -y python" $LINENO
assert "curl -O https://www.python.org/ftp/python/3.6.8/Python-3.6.8rc1.tgz" $LINENO
assert "tar xf Python-3.6.8rc1.tgz" $LINENO
assert "cd Python-3.6.8rc1/" $LINENO
assert "./configure" $LINENO
assert "make" $LINENO
assert "sudo make install" $LINENO
cd ..
sleep 3
#assert "python3 --version" $LINENO
assert "sudo yum install -y python3-pip" $LINENO
assert "pip3 --version" $LINENO
assert "python3 -m venv env" $LINENO
assert "source ./env/bin/activate" $LINENO
assert "pip3 install fabric" $LINENO
assert "pip3 install selenium" $LINENO
assert "wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm" $LINENO
assert "sudo yum install -y ./google-chrome-stable_current_*.rpm" $LINENO
assert "deactivate" $LINENO



# The remainder of the script executes only if the "assert" does not fail.

echo "This statement echoes only if the \"assert\" does not fail."
exit $?
