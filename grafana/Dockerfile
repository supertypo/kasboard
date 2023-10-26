FROM grafana/grafana:7.5.17

COPY grafana/grafana.ini ${GF_PATHS_CONFIG}
COPY grafana/kaspa.json ${GF_PATHS_HOME}
COPY grafana/provisioning ${GF_PATHS_PROVISIONING}
COPY grafana/web/ ${GF_PATHS_HOME}
