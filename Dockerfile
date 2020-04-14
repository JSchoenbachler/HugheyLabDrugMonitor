# Mostly pulled from the rxivist Dockerfile, with some updates.
# Please support/look into their much more well documented and implemented codebase: https://github.com/blekhmanlab/rxivist
FROM python:slim
# NOTE: The python:alpine image would be lovely
# to use here, but it isn't compatible with the
# postgres SDK, per this issue:
# https://github.com/psycopg/psycopg2/issues/699

LABEL org.label-schema.schema-version = "1.0.0-rc.1"

LABEL org.label-schema.vendor = "Hughey Lab"
LABEL org.label-schema.name = "Drug Monitor API"
LABEL org.label-schema.description = "The Drug Monitor API web application, a Python-based interface built using the Bottle framework."
LABEL org.label-schema.vcs-url = "https://github.com/JSchoenbachler/HugheyLabDrugMonitor"
LABEL org.label-schema.url = "https://www.hugheylab.org/"
LABEL maintainer="josh.schoenbachler@vumc.org"

LABEL org.label-schema.version = "0.7.0"

COPY requirements.txt /
RUN pip install -r /requirements.txt

RUN apt-get update
RUN apt install -y curl

ADD . /app
WORKDIR /app

HEALTHCHECK --start-period=30s --interval=120s --timeout=15s CMD curl --fail http://localhost/v1/general_exposures || exit 1

CMD ["python", "main.py"]
