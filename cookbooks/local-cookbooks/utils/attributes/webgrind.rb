#
# Cookbook Name:: utils
# Attributes:: webgrind
#
# Copyright 2014 dStack Development Team
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['utils']['webgrind']['docroot'] = '/var/www/webgrind'
default['utils']['webgrind']['domain'] = ''

default['utils']['webgrind']['storageDir'] = ''
default['utils']['webgrind']['profilerDir'] = '/tmp'

default['utils']['webgrind']['preprocessedSuffix'] = '.webgrind'

default['utils']['webgrind']['defaultTimezone'] = 'America/New_York'
default['utils']['webgrind']['dateFormat'] = 'Y-m-d H:i:s'
default['utils']['webgrind']['defaultCostformat'] = 'percent'
default['utils']['webgrind']['defaultFunctionPercentage'] = 90
default['utils']['webgrind']['defaultHideInternalFunctions'] = 'false'

default['utils']['webgrind']['pythonExecutable'] = '/usr/bin/python'

default['utils']['webgrind']['dotExecutable'] = '/usr/bin/dot'

default['utils']['webgrind']['fileUrlFormat'] = 'index.php?op=fileviewer&file=%1$s#line%2$d'

default['utils']['webgrind']['traceFileListFormat'] = '%i (%f) [%s]'
