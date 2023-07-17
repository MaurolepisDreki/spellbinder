# Primal Runes Configuration Bootstraps
using module/dirs

using module/m4
push_src_dir primalrunes
push_bin_dir build/primalrunes
m4_target config.sh config.m4 translate.sh.m4
pop_src_dir
pop_bin_dir

using assert_dir
assert_dir build/primalrunes
using_dir build/primalrunes
using config

