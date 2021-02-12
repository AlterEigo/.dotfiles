#!/usr/bin/env bash

# Script data
dirpath=$(pwd)
basedir=${0%/*}
templatesdir="$HOME/.templates"
sh_modulesdir="$basedir/sh-modules"
shname="${shname:=${0##*/}}"

# Project configuration
sourcedir="${dirpath}/sources"
headerdir="${dirpath}/headers"
layoutdir="${dirpath}/resources/xml"
stylesdir="${dirpath}/resources/css"

# Sourcing functions from libraries
source "$sh_modulesdir/crmadmin_component"

# Function declarations
main() {
	cmd=$1
	rest=${*#$cmd}
	if [[ -z "$*" ]]; then
		echo "$shname: No arguments provided."
		exit 1
	fi
	ops=( "component" )
	for c in ${ops[@]}; do
		if [[ "$cmd" == "$c" ]]; then
			$c $rest
			exit 0
		fi
	done
	echo "$shname: Command not found '$cmd'."
	exit 1
}

# Main component module router
component() {
	cmd=$1
	rest=${*#$cmd}
	if [[ -z "$*" ]]; then
		echo "$shname::$FUNCNAME: No arguments provided."
		exit 1
	fi
	if [[ -z "$mod_crmcmp" ]]; then
		echo "$shname::$FUNCNAME: Component library not found."
		exit 1
	fi
	declare -A ops
	ops=${mod_crmcmp}
	for c in ${ops[@]}; do
		if [[ "$cmd" == "$c" ]]; then
			$cmd $rest
			exit 0
		fi
	done
	echo "$shname::$FUNCNAME: Command not found '$cmd'."
	exit 1
}

# Main function call
main ${*#$0}
