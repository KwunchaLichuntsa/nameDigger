#!/bin/bash
#
#@Version 0.1

nsHostnet=(ns.cp.hostnet.nl ns1.cp.hostnet.nl ns3.cp.hostnet.nl)
nsOpts=("-n" "-d")
domain=$1
opts=$2
nsUserInput=$3
dnsRecordResults=()

# Validate input if they are empty or valid
function inputValidation() 
{
	local exitCode=0
	if [[ -z "$domain" ]] || [[ "$domain" == "${nsOpts[0]}" || "$domain" == "${nsOpts[1]}" ]]
		then
			writeToConsole "|--< No domainname provided..."
			return 1
	fi
#	case $domain in 
#		[!a-zA-Z_]* | *[!a-zA-z0-9_]*) 
#		echo $domain
#		return 1
#		;;
#	esac
	return $exitCode
}

# Exec whois for corresponding domainname
function whoIs()
{
	printf "niks"
}

function checkAutomate()
{
	curl -s 'http://automate.hostnetbv.nl/spam.php' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64)' --data 'domainname='jaspergroot.eu'&check=Check+Destination' | grep -oP '<h3><pre>\K(*)'
}

# Exec dig for DNS records
function checkDNSRecords()
{
	local dnsRecords=("mx" "a" "ns" "txt")
	local spf="v=spf1"
	it=${#dnsRecords[@]}

	for (( i = 0; i < it; i++ ));
	do
		dnsRecordResults[i]="$(`exec` "dig" ${dnsRecords[i]} $domain  "+short")"
	done
}

# Write results to screen
function writeToConsole() 
{
	line="##########################################################"
	printf '##%s\n' $line "${@}" $line
}

# Clean used variables
function cleanUp()
{
	printf "$1\n"
}

# Exit program
function exitT()
{
	printf "niks"
}

if inputValidation == "0"
then
	checkDNSRecords ""
	writeToConsole "${dnsRecordResults[@]}"
else
	writeToConsole "|--< Failure!.."
fi
exit
