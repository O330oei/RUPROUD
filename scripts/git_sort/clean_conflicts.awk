#!/usr/bin/awk -f

# Copyright (C) 2018 SUSE LLC
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
# USA.

BEGIN {
	conflicts = 0
}

/^Conflicts:$/ {
	conflicts = 1
	getline
	next
}

/^---$/ {
	if (conflicts == 0) {
		print lastLine
	}
	conflicts = 2
}

{
	#print "statement 3 conflicts " conflicts $0
	if (conflicts == 0) {
		if (NR != 1) {
			print lastLine
		}
		lastLine = $0
	} else if (conflicts == 2) {
		print
	}
}
