#!/bin/bash

if [[ -n "$PHPDOC_AUTHOR" ]];
	then printenv PHPDOC_AUTHOR
	else niutil -readprop / "/users/$USER" realname
fi
