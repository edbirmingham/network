#!/bin/bash
MONPATH="/home/ubuntu/workspace/mongo"
LOGFILE="$MONPATH/mongod.log"
ISNEW="0"

echo "Checking for mongo installation."
if [ ! -d $MONPATH ];
then
    echo "Creating new mongo directory."
    ISNEW=1
    mkdir $MONPATH
fi

echo "Checking to see if mongo is running."
MONGORUN="$(pidof mongod | wc -l)"
if [ $MONGORUN = "0" ]; then
    echo "Staring mongo."
    mongod --dbpath $MONPATH --smallfiles --fork --logpath $LOGFILE
else
    echo "Mongo already running."
fi

if [ "$ISNEW" = "1" ]; then
    echo "Initializing new mongo database."
    grunt initdb
fi

echo "Starting Network."
grunt