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
load("//:cmake_helpers.bzl", "cmake_add_dep_mapping", "cmake_fetch_content_package", "cmake_raw", "cmake_set_section")

# REPO_BRANCH = master

def repo():
    maybe(
        third_party_http_archive,
        name = "com_google_absl",
        strip_prefix = "abseil-cpp-20220623.0",
        urls = [
            "https://github.com/abseil/abseil-cpp/archive/20220623.0.tar.gz",
        ],
        sha256 = "4208129b49006089ba1d6710845a45e31c59b0ab6bff9e5788a87f55c5abd602",
    )

# Mapping from BAZEL dependency to CMake targets.
ABSL_CMAKE_MAPPING = {
    "@com_google_absl//absl/algorithm:algorithm": "absl::algorithm",
    "@com_google_absl//absl/algorithm:container": "absl::algorithm_container",
    "@com_google_absl//absl/base:base": "absl::base",
    "@com_google_absl//absl/base:core_headers": "absl::core_headers",
    "@com_google_absl//absl/base:dynamic_annotations": "absl::dynamic_annotations",
    "@com_google_absl//absl/base:log_severity": "absl::log_severity",
    "@com_google_absl//absl/cleanup:cleanup": "absl::cleanup",
    "@com_google_absl//absl/container:btree": "absl::btree",
    "@com_google_absl//absl/container:fixed_array": "absl::fixed_array",
    "@com_google_absl//absl/container:flat_hash_map": "absl::flat_hash_map",
    "@com_google_absl//absl/container:flat_hash_set": "absl::flat_hash_set",
    "@com_google_absl//absl/container:inlined_vector": "absl::inlined_vector",
    "@com_google_absl//absl/container:node_hash_map": "absl::node_hash_map",
    "@com_google_absl//absl/container:node_hash_set": "absl::node_hash_set",
    "@com_google_absl//absl/debugging:debugging": "absl::debugging",
    "@com_google_absl//absl/debugging:failure_signal_handler": "absl::failure_signal_handler",
    "@com_google_absl//absl/debugging:leak_check": "absl::leak_check",
    "@com_google_absl//absl/debugging:stacktrace": "absl::stacktrace",
    "@com_google_absl//absl/debugging:symbolize": "absl::symbolize",
    "@com_google_absl//absl/flags:commandlineflag": "absl::flags_commandlineflag",
    "@com_google_absl//absl/flags:config": "absl::flags_config",
    "@com_google_absl//absl/flags:flag": "absl::flags",
    "@com_google_absl//absl/flags:flags_marshalling": "absl::flags_marshalling",
    "@com_google_absl//absl/flags:marshalling": "absl::flags_marshalling",
    "@com_google_absl//absl/flags:parse": "absl::flags_parse",
    "@com_google_absl//absl/flags:reflection": "absl::flags_reflection",
    "@com_google_absl//absl/flags:usage": "absl::flags_usage",
    "@com_google_absl//absl/functional:bind_front": "absl::bind_front",
    "@com_google_absl//absl/functional:function_ref": "absl::function_ref",
    "@com_google_absl//absl/hash:hash": "absl::hash",
    "@com_google_absl//absl/memory:memory": "absl::memory",
    "@com_google_absl//absl/meta:meta": "absl::meta",
    "@com_google_absl//absl/meta:type_traits": "absl::type_traits",
    "@com_google_absl//absl/numeric:bits": "absl::bits",
    "@com_google_absl//absl/numeric:int128": "absl::int128",
    "@com_google_absl//absl/numeric:numeric": "absl::numeric",
    "@com_google_absl//absl/numeric:numeric_representation": "absl::numeric_representation",
    "@com_google_absl//absl/profiling:exponential_biased": "absl::exponential_biased",
    "@com_google_absl//absl/profiling:periodic_sampler": "absl::periodic_sampler",
    "@com_google_absl//absl/profiling:sample_recorder": "absl::sample_recorder",
    "@com_google_absl//absl/random:bit_gen_ref": "absl::random_bit_gen_ref",
    "@com_google_absl//absl/random:distributions": "absl::random_distributions",
    "@com_google_absl//absl/random:mocking_bit_gen": "absl::random_mocking_bit_gen",
    "@com_google_absl//absl/random:random": "absl::random_random",
    "@com_google_absl//absl/random:seed_gen_exception": "absl::random_seed_gen_exception",
    "@com_google_absl//absl/random:seed_sequences": "absl::random_seed_sequences",
    "@com_google_absl//absl/status:status": "absl::status",
    "@com_google_absl//absl/status:statusor": "absl::statusor",
    "@com_google_absl//absl/strings:cord": "absl::cord",
    "@com_google_absl//absl/strings:str_format": "absl::str_format",
    "@com_google_absl//absl/strings:strings": "absl::strings",
    "@com_google_absl//absl/synchronization:synchronization": "absl::synchronization",
    "@com_google_absl//absl/time:civil_time": "absl::civil_time",
    "@com_google_absl//absl/time:time": "absl::time",
    "@com_google_absl//absl/time:time_zone": "absl::time_zone",
    "@com_google_absl//absl/types:any": "absl::any",
    "@com_google_absl//absl/types:bad_any_cast": "absl::bad_any_cast",
    "@com_google_absl//absl/types:bad_optional_access": "absl::bad_optional_access",
    "@com_google_absl//absl/types:bad_variant_access": "absl::bad_variant_access",
    "@com_google_absl//absl/types:compare": "absl::compare",
    "@com_google_absl//absl/types:optional": "absl::optional",
    "@com_google_absl//absl/types:span": "absl::span",
    "@com_google_absl//absl/types:variant": "absl::variant",
    "@com_google_absl//absl/utility:utility": "absl::utility",
    # Internal targets mapping
    "@com_google_absl//absl/base:endian": "absl::base",
    "@com_google_absl//absl/base:config": "absl::base",
    # Not available in abseil CMakeLists.txt
    "@com_google_absl//absl/debugging:leak_check_disable": "",
    # Testonly targets
    "@com_google_absl//absl/hash:hash_testing": "absl::hash_testing",
    "@com_google_absl//absl/strings:cord_test_helpers": "absl::cord_test_helpers",
}

cmake_set_section(section = 200)

cmake_add_dep_mapping(target_mapping = ABSL_CMAKE_MAPPING)

# https://github.com/abseil/abseil-cpp/blob/master/CMake/README.md
cmake_fetch_content_package(
    name = "com_google_absl",
    settings = [
        ("ABSL_PROPAGATE_CXX_STD", "ON"),
        ("ABSL_BUILD_TESTING", "ON"),
        ("ABSL_USE_EXTERNAL_GOOGLETEST", "ON"),
        ("ABSL_FIND_GOOGLETEST", "OFF"),
    ],
)

# Ensure aliases exist.
cmake_raw(text = "\n")

[
    (
        cmake_raw(
            text = "check_absl_target({t})\n".format(t = v),
        ),
    )
    for v in ABSL_CMAKE_MAPPING.values()
    if v
]
