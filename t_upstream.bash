#!/bin/bash
#
# Copyright (c) 2024, Masatake YAMATO
# Copyright (c) 2024, Red Hat, Inc.
#
# upstream is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# upstream is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with upstream.  If not, see <http://www.gnu.org/licenses/>.
#

error()
{
    echo "$2" 1>&2
    exit "$1"
}

if [[ ! -d t_upstream_input ]]; then
    error 1 "no tests dir found"
fi

if [[ ! -r t_upstream_expected/query.txt ]]; then
    error 1 "no query.txt file found"
fi

if [[ ! -r t_upstream_expected/lcopy.txt ]]; then
    error 1 "no lcopy.txt file found"
fi

if [[ ! -e ./upstream ]]; then
    error 1 "no upstream script found"
fi

diff -uN <(for i in t_upstream_input/*.html; do
	       printf "%s => " $(basename $i .html)
	       bash ./upstream query --input $i
	   done) t_upstream_expected/query.txt || error 1 "failed in QUERY subcommand"

diff -uN <(for i in t_upstream_input/*.html; do
	       bash ./upstream lcopy --no-date --input $i $(basename $i .html)
	   done) t_upstream_expected/lcopy.txt || error 1 "failed in LCOPY subcommand"
