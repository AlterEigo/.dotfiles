#!/usr/bin/env bash

# Script data
dirpath=$(pwd)
basedir=${0%/*}
templatesdir="$HOME/.templates"
sh_modulesdir="$basedir/sh-modules"

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
	declare -A ops
	ops["component"]="component_handler"
	ops["pwd"]="dirpath"
	for c in ${!ops[@]}; do
		if [[ "$cmd" == "$c" ]]; then
			${ops[$c]} $rest
		fi
	done
}

dirpath() {
	echo "Current path is : $(pwd)"
}

# Main component module router
component_handler() {
	cmd=$1
	rest=${*#$cmd}
	if [[ -z "$mod_crmcmp+x" ]]; then
		echo "${0##*/}: Component library not found."
		exit
	fi
	declare -A ops
	ops=${mod_crmcmp}
	for c in ${ops[@]}; do
		if [[ "$cmd" == "$c" ]]; then
			$cmd $rest
		fi
	done
}

# Main function call
main ${*#$0}
