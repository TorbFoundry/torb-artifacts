name= $1
umbrella= $2
no_live= $3
no_ecto= $4
no_dash= $5
no_html= $6
no_assets= $7 

name= ${name//[^a-zA-Z0-9]/}

command= "mix phx.new ./$name"

if [ $umbrella == "true" ]; then
    command= "$command --umbrella"
fi

if [ $no_live == "true" ]; then
    command= "$command --no-live"
fi

if [ $no_ecto == "true" ]; then
    command= "$command --no-ecto"
fi

if [ $no_dash == "true" ]; then
    command= "$command --no-dash"
fi

if [ $no_html == "true" ]; then
    command= "$command --no-html"
fi

if [ $no_assets == "true" ]; then
    command= "$command --no-assets"
fi

eval $command

APP_NAME= $name

envsubst < Dockerfile > Dockerfile