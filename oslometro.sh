#!/bin/sh

# Declare variables
stopid=3010370
side=0
bold=$(tput bold)
normal=$(tput sgr0)

function convertNumberToCircledNumber() {
	if [ $result == "1" ]; then
		circledNumber="①"
	elif [ $result == "2" ]; then
		circledNumber="②"
	elif [ $result == "3" ]; then
		circledNumber="③"
	elif [ $result == "4" ]; then
		circledNumber="④"
	elif [ $result == "5" ]; then
		circledNumber="⑤"
	elif [ $result == "6" ]; then
		circledNumber="⑥"
	elif [ $result == "7" ]; then
		circledNumber="⑦"
	elif [ $result == "8" ]; then
		circledNumber="⑧"
	elif [ $result == "9" ]; then
		circledNumber="⑨"
	fi
}

# Loop through arguments
for i; do
	if [ $i == "--W" ]; then
		side=1
	elif [ $i == "--E" ]; then
		side=2
	else
		stopid=$i
	fi
done

# Get data
results=$(curl -s "http://mon.ruter.no/SisMonitor/Refresh?stopid=${stopid}&computerid=7498d94a-eaf2-4c1b-8015-8c076805242e&isOnLeftSide=true&blocks=&rows=10&test=&stopPoint=" | grep "<td class=\"linenumbercol\">\|<td class=\"departurecol\">\|<td>" | sed 's/<[^>]*>//g' | sed 's/^[ \t]*//g' | tr -d "\r")

# Print data

IFS='
'

outputWest="  L\t DESTINATION \t DEPATURE \t PLF\n ───\t───────────────────────────────\t──────────\t─────\n"
outputEast="  L\t DESTINATION \t DEPATURE \t PLF\n ───\t───────────────────────────────\t──────────\t─────\n"
line=""
count=0
westDest=""
eastDest=""
for result in $results; do
	count=$((count+1))
	if [ $count -eq 1 ]; then
		convertNumberToCircledNumber $result
		line+=$(echo -e "  $circledNumber \t" | sed 's/&#229;/å/')
	elif [ $count -lt 4 ]; then
		line+=$(echo -e " $result \t" | sed 's/n&#229;/now/')
	elif [ $count -eq 4 ]; then
		result2=$(echo $result | grep -o -E '[0-9]+' | head -1 | sed -e 's/^0\+//')
		result=${result:3:-1}
		line+="  $result2\n"
		if [ $result2 == "1" ]; then
			westDest=${result:8}
			outputEast+=$line
		else
			eastDest=${result:8}
			outputWest+=$line
		fi
		line=""
		count=0
	fi
done

if [ $side -ne 2 ]; then
	echo
	echo -e "Departures heading towards ${bold}${westDest}${normal}"
	echo
	echo -e $outputWest | head -n 5 | column -t -o "│" -s $'\t'
	echo
fi

if [ $side -ne 1 ]; then
	echo
	echo -e "Departures heading towards ${bold}${eastDest}${normal}"
	echo
	echo -e $outputEast | head -n 5 | column -t -o "│" -s $'\t'
	echo
fi
