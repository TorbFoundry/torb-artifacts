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
port=${10}

docker_template="Dockerfile.template"

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
    dockerfile_template="Dockerfile.react.template"
    command="$command --no-assets"
fi

mix archive.install hex phx_new 1.7.0 --force

command="$command --install"

#Switch working dir to the script's directory.
#https://stackoverflow.com/questions/6393551/what-is-the-meaning-of-0-in-a-bash-script
#Check the accepted answer for what's going on with this.
cd "${0%/*}"

eval $command

pushd $name

MIX_ENV=prod mix phx.gen.release

popd

ELIXIR_VERSION=1.14.3
ERLANG_VERSION=23.3.4.14
OS=ubuntu
OS_VERSION=xenial-20210804
BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${ERLANG_VERSION}-${OS}-${OS_VERSION}"
RUNNER_IMAGE="${OS}:${OS_VERSION}"
MIX_ENV="prod"

df_output="$(MIX_ENV=$MIX_ENV BUILDER_IMAGE=$BUILDER_IMAGE RUNNER_IMAGE=$RUNNER_IMAGE PORT=$port APP_NAME="$name" envsubst < $dockerfile_template)"

echo "$df_output" > ./Dockerfile

rm ./Dockerfile.template
rm ./Dockerfile.react.template
rm ./init.sh
