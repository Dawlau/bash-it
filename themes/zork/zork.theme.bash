SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓${normal}"
#SCM_GIT_CHAR="${bold_green}±${normal}"
SCM_SVN_CHAR="${bold_cyan}⑆${normal}"
SCM_HG_CHAR="${bold_red}☿${normal}"

#Mysql Prompt
export MYSQL_PS1="(\u@\h) [\d]> "

case $TERM in
        xterm*)
        TITLEBAR="\[\033]0; Bash\007\]"
        ;;
        *)
        TITLEBAR=""
        ;;
esac

PS3=">> "

__my_rvm_ruby_version() {
    local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
  [ "$gemset" != "" ] && gemset="@$gemset"
    local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')
    local full="$version$gemset"
  [ "$full" != "" ] && echo "[$full]"
}

is_vim_shell() {
        if [ ! -z "$VIMRUNTIME" ]
        then
                echo "[${cyan}vim shell${normal}]"
        fi
}

modern_scm_prompt() {
        CHAR=$(scm_char)
        if [ $CHAR = $SCM_NONE_CHAR ]
        then
                return
        else
                echo "[$(scm_char)][$(scm_prompt_info)]"
        fi
}

# show chroot if exist
chroot(){
    if [ -n "$debian_chroot" ]
    then
        my_ps_chroot="${bold_cyan}$debian_chroot${normal}";
        echo "($my_ps_chroot)";
    fi
    }

# show virtualenvwrapper
my_ve(){

    if [ -n "$CONDA_DEFAULT_ENV" ]
    then
        my_ps_ve="${bold_purple}${CONDA_DEFAULT_ENV}${normal}";
        echo "($my_ps_ve)";
    elif [ -n "$VIRTUAL_ENV" ]
    then
        my_ps_ve="${bold_purple}$ve${normal}";
        echo "($my_ps_ve)";
    fi
    echo "";
    }

prompt() {

    my_ps_user="\[\033[31m\]\u\[\033[32m\]"
    my_ps_root="\[\033[31m\]\u\[\033[32m\]";
    bash_text="\[\033[36m\]\s\[\033[32m\]"

    if [ -n "$VIRTUAL_ENV" ]
    then
        ve=`basename "$VIRTUAL_ENV"`;
    fi

    # nice prompt
    case "`id -u`" in
        0) PS1="${TITLEBAR}\[\033[31m\]┌─\[\033[32m\]$(my_ve)$(chroot)\[\033[31m\][\[\033[32m\]$my_ps_user\[\033[33m\]@\[\033[32m\]$bash_text\[\033[31m\]]\[\033[32m\]$(__my_rvm_ruby_version)\[\033[31m\]-[\[\033[32m\]${green}\w${normal}\[\033[31m\]]\[\033[32m\]$(is_vim_shell)
\[\033[31m\]└─▪\[\033[32m\] \[\033[33m\]#\[\033[32m\] "
        ;;
        *) PS1="${TITLEBAR}\[\033[31m\]┌─\[\033[32m\]$(my_ve)$(chroot)\[\033[31m\][\[\033[32m\]$my_ps_user\[\033[33m\]@\[\033[32m\]$bash_text\[\033[31m\]]\[\033[32m\]$(__my_rvm_ruby_version)\[\033[31m\]-[\[\033[32m\]${green}\w${normal}\[\033[31m\]]\[\033[32m\]$(is_vim_shell)
\[\033[31m\]└─▪\[\033[32m\] \[\033[33m\]#\[\033[32m\] "
        ;;
    esac
}

PS2="└─▪ "



safe_append_prompt_command prompt
