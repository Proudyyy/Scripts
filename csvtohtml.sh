#!/bin/bash
function salir {
echo -e "Usage: $0 [csv_file]"
exit 1
}
if [ $# -ne 1 ] || ! [ -f $1 ]; then
  salir
fi
tmp="./temp.csv"
table="./table.html"
sed 's/^;//g' $1 > $tmp
sed -i 's/;$//g' $tmp

echo "<table border='1'>" > $table
while read line ; do
echo "<tr>" >> $table
#change ; to character you want to delimite
echo $line | sed -e 's/^/<td>/' -e 's/;/<\/td><td>/g' -e 's/$/<\/td>/' >> $table
echo "</tr>" >> $table
done < $tmp
echo "</table>" >> $table
rm $tmp