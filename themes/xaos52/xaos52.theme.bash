#!/usr/bin/env bash

SCM_THEME_PROMPT_PREFIX="${cyan}(${green}"
SCM_THEME_PROMPT_SUFFIX="${cyan})"
SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${green}✓"

# setmypwd() {
#     mypwd=$(
#         while read -rd /; do
#             printf /%.1s "$REPLY"
#         done <<< "${PWD#/}"
#         printf /%s "$REPLY"
#     )
# }
setmypwd() {
    mypwd=""
    while read -rd /; do
        mypwd+="/${REPLY:0:1}"
    done <<< "${PWD#/}"
    mypwd+="/${REPLY%$'\n'}"
}
cd() { builtin cd "$@" || return; setmypwd; }
pushd() { builtin pushd "$@" || return; setmypwd; }
popd() { builtin popd "$@" || return; setmypwd; }

setmypwd

prompt() {
  PS1="$(scm_prompt_info)${reset_color} ${cyan}${mypwd}${reset_color} "
}

PROMPT_COMMAND=prompt
