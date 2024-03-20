#! /bin/zsh
clear
searching=true
echo "leopard industries' webdirdown"
echo "enter the URL of the directory you wish to browse"
read url
clear
echo "connecting..."
sleep 1
echo "enumerating remote directory..."
wget -q --spider -r --no-parent $url
IFS="/" read name dir <<< $url
dir=${dir//"%20"/" "}
clear
echo "connected to remote directory $dir"
sleep 2.5
echo ""
echo "set current directory..."
sleep 2.5
clear
IFS="/" read name dir <<< $dir
cd $dir
while $searching
do
	echo ""
	echo "files in directory:"
	echo ""
	ls
	echo ""
	echo "input target file or directory"
	echo ""
	read target
	clear
	if [[ $target == *.* ]] ; then
		searching=false
		clear
		echo ""
		echo "user requested file..."
		sleep 1
		current=`pwd`
		basename=`basename "$current"`
		clear
		dl=$url$basename/$target
		dl=${dl//" "/"%20"}
		wget -q -P  ~/Downloads/webdirdown/ $dl
		clear
		echo ""
		echo "file saved to downloads... exiting..."
		cd ~/Downloads/webdirdown/
	else
		cd $target
	fi
done
