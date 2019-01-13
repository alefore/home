# Bash knows 3 diferent shells: normal shell, interactive shell, login shell.
# ~/.bashrc is read for interactive shells and ~/.profile is read for login
# shells. We just let ~/.profile also read ~/.bashrc and put everything in
# ~/.bashrc.

test -z "$PROFILEREAD" && . /etc/profile

# commands common to all logins

if ! [ $TERM ] ; then
    eval `tset -s -Q`
    case $TERM in
      con*|vt100) tset -Q -e ^?
        ;;
    esac
fi

# try to set DISPLAY smart (from Hans) :)
#
if test -z "$DISPLAY" -a "$TERM" = "xterm" -a -x /usr/bin/who ; then
    WHOAMI="`/usr/bin/who am i`"
    _DISPLAY="`expr "$WHOAMI" : '.*(\([^\.][^\.]*\).*)'`:0.0"
    if [ "${_DISPLAY}" != ":0:0.0" -a "${_DISPLAY}" != " :0.0" \
         -a "${_DISPLAY}" != ":0.0" ]; then
        export DISPLAY="${_DISPLAY}";
    fi
    unset WHOAMI _DISPLAY
fi

export DISPLAY

if test -e ~/.prompt; then
  . ~/.prompt;
elif test -e /etc/prompt; then
  . /etc/prompt;
fi

test -e /etc/alias  && . /etc/alias
test -e ~/.alias    && . ~/.alias

umask 022

if test -e ~/.ssh-agent >/dev/null; then
  . ~/.ssh-agent > /dev/null
fi

# Let me override any commands placing scripts in ~/bin.  Also let me execute
# directly all the useful commands in sbin that don't require root privileges.
PATH="~/bin:$PATH:/sbin/"

#if test -e /etc/bash_completion >/dev/null; then
#  . /etc/bash_completion >/dev/null || echo "Bash completion failed to load";
#fi

function getrc {
  for file in /etc/init.d/*; do
    if test -x $file; then
      alias $(echo $file | sed 's/^\/etc\/init.d\//rc/' | sed 's/.sh$//')="$file";
    fi;
  done;
}

TZ='Europe/Zurich';
#TZ='America/Los_Angeles'
export TZ

if test -d ~/.bash
then
  for file in ~/.bash/*
  do
    source $file
  done
fi

if test -d ~/.private >/dev/null; then
  for dir in ~/.private/*; do
    if test -f $dir/.bashrc; then
      . $dir/.bashrc;
    fi
    if test -d $dir/bin; then
      PATH="$PATH:$dir/bin"
    fi
  done;
fi;

alias vi="vi -X"
alias gc="git checkout"

export LC_CTYPE=en_US.utf-8
SHELL=/bin/bash
export EDITOR=edge
