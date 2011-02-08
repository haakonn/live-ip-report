#!/bin/sh

PING=/bin/ping
AWK=/usr/bin/awk
HOST=/usr/bin/host
CUT=/usr/bin/cut
SEQ=/usr/bin/seq
HEAD=/usr/bin/head

REPORTFILE=$1.live

echo -n > $REPORTFILE

for x in $($SEQ 1 254)
do
    ip="$1.$x"
    $PING -q -c 1 $ip >/dev/null &&
    h=$($HOST $ip | $HEAD -1 | $AWK '{print $NF}' | $CUT -d. -f1) &&
    echo "$ip $h" >> $REPORTFILE
done
