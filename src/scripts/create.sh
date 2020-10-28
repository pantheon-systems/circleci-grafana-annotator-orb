Create() {
  if [[ -z "${PARAM_GRAFANA_URL:-}" ]]; then
    echo "WARNING: Missing env var PARAM_GRAFANA_URL. Skipping Grafana deployment annotation"
    return
  fi

  if [[ -z "${PARAM_GRAFANA_CERT:-}" ]]; then
    echo "WARNING: Missing env var PARAM_GRAFANA_CERT. Skipping Grafana deployment annotation"
    return
  fi

  if [[ -z "${PARAM_TAGS:-}" ]]; then
    echo "WARNING: Missing env var PARAM_TAGS. Skipping Grafana deployment annotation"
    return
  fi

  if [[ -z "${PARAM_WHAT:-}" ]]; then
    echo "WARNING: Missing env var PARAM_WHAT. Skipping Grafana deployment annotation"
    return
  fi


  # graphite annotation format because it is simpler. This is still stored in Grafana's native
  # annotation database (ie: cloudsql)
  # https://grafana.com/docs/grafana/latest/http_api/annotations/#create-annotation-in-graphite-format
  payload=$(
    cat <<EOF
  {
    "data": "$PARAM_DATA",
    "tags": `echo "$PARAM_TAGS" | jq -R . | jq -s .`,
    "what": "$PARAM_WHAT",
    "when": "$PARAM_WHEN"
  }
EOF
  )

  curl -s -k \
  -X POST "$PARAM_GRAFANA_URL/api/annotations/graphite" \
  -E "$PARAM_GRAFANA_CERT" \
  -H 'content-type: application/json' \
  --data-binary @- <<<"$payload"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
  Create
fi
