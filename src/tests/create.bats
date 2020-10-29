# Runs prior to every test
setup() {
    # Load our script file.
    source ./src/scripts/create.sh
}

@test '1: Curls the url with correct payload' {
    # Mock environment variables or functions by exporting them (after the script has been sourced)
    export PARAM_DATA="some data"
    export PARAM_GRAFANA_CERT="my-cert"
    export PARAM_GRAFANA_URL="example.com"
    export PARAM_TAGS="a-tag, b-tag, c-tag"
    export PARAM_WHAT="example annotation"
    export PARAM_WHEN="1603846674"

    # Capture the output of our "Create" function
}
