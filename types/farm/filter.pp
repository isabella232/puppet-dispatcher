#
# Puppet Dispatcher Module - A module to manage AEM Dispatcher installations and configuration files.
#
# Copyright 2019 Adobe Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Filter attributes hash.
# @summary A hash of filter attributes.
#   Used to configure the `/filter` parameter instance of a Farm.
#
type Dispatcher::Farm::Filter = Struct[
  {
    rank      => Integer[0],
    allow     => Boolean,
    Optional[url]       => Dispatcher::Farm::Filter::Pattern,
    Optional[method]    => Dispatcher::Farm::Filter::Pattern,
    Optional[query]     => Dispatcher::Farm::Filter::Pattern,
    Optional[protocol]  => Dispatcher::Farm::Filter::Pattern,
    Optional[path]      => Dispatcher::Farm::Filter::Pattern,
    Optional[selectors] => Dispatcher::Farm::Filter::Pattern,
    Optional[extension] => Dispatcher::Farm::Filter::Pattern,
    Optional[suffix]    => Dispatcher::Farm::Filter::Pattern,
  }
]

