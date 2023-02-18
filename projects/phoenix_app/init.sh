#!/bin/bash

name=$1
umbrella=$2
no_live=$3
no_ecto=$4
no_dash=$5
no_html=$6
no_assets=$7
database=$8
dfm_workaround=$9

name=${name//[^a-zA-Z0-9_]/}

command="mix phx.new ./$name"

if [ "$umbrella" = "true" ]; then
    command="$command --umbrella"
fi

if [ "$database" != "" ]; then
    database=${database//[^a-zA-Z0-9]/}
    command="$command --database $database"
else
    command="$command --database postgres"
fi

if [ "$no_live" = "true" ]; then
    command="$command --no-live"
fi

if [ "$no_ecto" = "true" ]; then
    command="$command --no-ecto"
fi

if [ "$no_dash" = "true" ]; then
    command="$command --no-dashboard"
fi

if [ "$no_html" = "true" ]; then
    command="$command --no-html"
fi

if [ "$no_assets" = "true" ]; then
    command="$command --no-assets"
fi

mix archive.install hex phx_new 1.6.16 --force

command="$command --install"

#Switch working dir to the script's directory.
#https://stackoverflow.com/questions/6393551/what-is-the-meaning-of-0-in-a-bash-script
#Check the accepted answer for what's going on with this.
cd "${0%/*}"

eval $command

ELIXIR_VERSION=v1.14.3
ERLANG_VERSION=23

df_output="$(ELIXIR_VERSION=$ELIXIR_VERSION ERLANG_VERSION=$ERLANG_VERSION APP_NAME="$name" envsubst < Dockerfile.template)"


echo "$df_output" > ./Dockerfile

rm ./Dockerfile.template
rm ./init.sh
