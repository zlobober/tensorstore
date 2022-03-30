# Copyright 2020 The TensorStore Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load(
    "//third_party:repo.bzl",
    "third_party_http_archive",
)
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//:cmake_helpers.bzl", "cmake_fetch_content_package", "cmake_use_absl_style_mapping")

# REPO_BRANCH = master

def repo():
    maybe(
        third_party_http_archive,
        name = "com_google_absl",
        strip_prefix = "abseil-cpp-20211102.0",
        urls = [
            "https://github.com/abseil/abseil-cpp/archive/20211102.0.tar.gz",
        ],
        sha256 = "dcf71b9cba8dc0ca9940c4b316a0c796be8fab42b070bb6b7cab62b48f0e66c4",
    )

# https://github.com/abseil/abseil-cpp/blob/master/CMake/README.md
cmake_fetch_content_package(
    name = "absl",
    settings = [
        ("ABSL_USE_EXTERNAL_GOOGLETEST", "ON"),
        ("ABSL_BUILD_TESTING", "OFF"),
        ("ABSL_FIND_GOOGLETEST", "OFF"),
        ("ABSL_PROPAGATE_CXX_STD", "ON"),
    ],
)

cmake_use_absl_style_mapping(
    prefix_mapping = {
        "@com_google_absl//absl": "absl",
    },
)
