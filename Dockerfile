FROM camerontaylor/postgres-plv8:9.6-2.0

MAINTAINER Cameron Taylor <cameron.taylor@webfrontgears.com>

RUN buildDependencies="make curl ca-certificates postgresql-server-dev-$PG_MAJOR unzip" \
  && apt-get update \
  && apt-get install -y --no-install-recommends postgresql-$PG_MAJOR-mysql-fdw ${buildDependencies} \
  && mkdir -p /tmp/build \
  && curl -o /tmp/build/pg_datatype_password.zip -SL "https://github.com/ozum/pg_datatype_password/archive/master.zip" \
  && cd /tmp/build/ \
  && unzip pg_datatype_password.zip \
  && cd pg_datatype_password-master \
  && make install \
  && cd / \
  && apt-get clean \
  && apt-get remove -y  ${buildDependencies} \
  && apt-get autoremove -y \
  && rm -rf /tmp/build /var/lib/apt/lists/*
