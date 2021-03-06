# -*- coding: utf-8 -*-
#
# This file is part of RERO MEF.
# Copyright (C) 2018 RERO.
#
# RERO MEF is free software; you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# RERO MEF is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with RERO MEF; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA 02111-1307, USA.
#
# In applying this license, RERO does not
# waive the privileges and immunities granted to it by virtue of its status
# as an Intergovernmental Organization or submit itself to any jurisdiction.


LABEL maintainer="software@rero.ch"

LABEL description="MEF (Multilingual Entity File) server with records for persons, works, etc. for reuse in integrated library systems (ILS)."

FROM rero-mef-base:latest

USER 0

COPY ./ ${WORKING_DIR}/src
WORKDIR ${WORKING_DIR}/src
COPY ./docker/uwsgi/ ${INVENIO_INSTANCE_PATH}

RUN chown -R invenio:invenio ${WORKING_DIR}

USER 1000

# workaround
RUN npm uninstall --prefix `pipenv --venv` --silent -g node-sass clean-css uglify-js requirejs

RUN ./scripts/bootstrap --deploy

