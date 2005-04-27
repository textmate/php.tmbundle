#!/bin/bash

AUTHOR=`echo $PHPDOC_AUTHOR`
if [ ! $AUTHOR ]
then
    niutil -readprop / /users/$USER realname
else
    echo $AUTHOR
fi