# ScummVM - Graphic Adventure Engine
# Copyright (C) 2021 Stryzhniou Fiodar

# ScummVM is the legal property of its developers, whose names
# are too numerous to list here. Please refer to the COPYRIGHT
# file distributed with this source distribution.

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.


from __future__ import with_statement
import os
from common_names import *

hrh_template = """
/*
 * Warning: autogenerated file
 */
#ifndef ScummHRH
#define ScummHRH

#if defined (UIQ3) || defined (__SERIES60_3X__)
#ifdef SCUMMVM_PT_1
#define ScummUid %s
%s#endif // SCUMMVM_PT_1

#else
#define ScummUid 0x101f9b57
#endif // defined (UIQ3) || defined (__SERIES60_3X__)

#endif
"""
macro_templatte = """#elif defined (SCUMMVM_PT_%s)
#define ScummUid %s
"""

def Generate_ScummVm_hrh(build):
   uids = get_UIDs(build)
   defines = ""
   for i in range(len(uids)):
      if i > 1:
         defines += macro_templatte %(i, uids[i])
   data = hrh_template %(uids[0], defines)
   SafeWriteFile(os.path.join("src", "ScummVm.hrh"), data)

if __name__ == "__main__":
   Generate_ScummVm_hrh(build = "S60v3")

   