#create appropriate folders 


#cd /Users/austinstone/Desktop/HeadPoseImageDB/
#for ((i = -90; i<=90; i =i+5))
#do
#	echo $i
#	if [ "$i" -ge 0 ];
#    then
#		mkdir "angle+"$i
#	else
#		mkdir "angle-"$i
#	fi
	#mkdir "angle"$i
#done	



#iterate through all directories and move all faces looking the same way to the appropriate folder 
for dir in /Users/austinstone/Desktop/HeadPoseImageDB/*
do
    dir=${dir%*/}
    echo ${dir##*/}
    cd $dir
    for f in *
    do
    	echo "Processing $f file..."
    	#b=${f:5:3}
        #if [ $b = '+05' ]; then
    	    #echo $b
            #cp $f ../"angle+5/"
        #fi
       # if [ $b = '-05' ]; then
        #    echo $b
         #   cp $f ../"angle-5/"
        #fi

    	#if [ "$b" = "0.j" ]; then
    	 #   cp $f ../"angle+0/"
    	#else
    	#	cp $f ../"angle"$b
    	#fi       
    done

    cd ../
done