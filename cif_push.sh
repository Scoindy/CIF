#!/bin/bash
###############################################################################
# Name        : cif_push.sh
# Description : adds and  commits (optionally) into local repositories
#               and pushesA changes to remote (github)
# Author      : Scott Walkinshaw
# Date        : 17th August 2010
#
# Notes       : config is stored in global gitconfig in the following format
#               where name is the name of the local git repository and
#               <action> is an integer to manage repository state
#               prior to the push:
#                 0	-	push Head
#                 1 	-	commit all changes,push Head
#                 2 	-	add everything,commit all changes,push Head
#
#             [sync]
#	              rep001 = <name>:<action>
#	              rep002 = <name>:<action>
#              
#             e.g.  git config --global sync.rep001 "scoindy:2"
#                   git config --global sync.rep002 "test:0"
#
#               GITHOME must be set correctly or passed as $1
#
###############################################################################
###############################################################################
# File Modification History                                                   #
###############################################################################
# Inits | Date      | Vers | Description                                      #
# SW    | 17 Aug 10 | 0.01 | Initial Issue                                    #
###############################################################################
GITHOME=${GITHOME:-$1}
MESS1="[$(whoami)@$(hostname)] Continuous Integration Framework"
MESS2="[auto commit and push]"
git commit -m "$MESS1" -m "$MESS2"
IFS=":"
git config --get-regexp '^sync\.r[0-9]\d{,3}' | cut -d' ' -f2 | while read REP ACT; do

  echo -e "processing repository [$REP] . . . \n"
  git status $GITHOME/$REP
  
  case $ACT in
      0) MESS2="[auto push HEAD]
         git commit --ammend < $MESS2
         git push origin
         ;;
      1) echo "TO DO"
         ;;
      3) git status
         git add *
         git commit -a -m "$MESS1" -m "$MESS2"
         git push origon
         ;;
      *) echo "die."
        ;;
    esac

done
