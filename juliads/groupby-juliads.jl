#!/usr/bin/env julia

print("# groupby-juliads.jl\n"); flush(stdout);

using InMemoryDatasets;
using CSV;
using Printf;
using DLMReader;
using PooledArrays
# Precompile methods for common patterns
# DataFrames.precompile(true)
IMD.warmup()
include("$(pwd())/_helpers/helpersds.jl");

pkgmeta = getpkgmeta("InMemoryDatasets");
ver = pkgmeta["version"];
git = "kfahdlkfhaslh";
task = "groupby";
solution = "juliads";
fun = "by";
cache = true;
on_disk = false;

data_name = ENV["SRC_DATANAME"];
src_grp = string("_data/", data_name, ".csv");
println(string("loading dataset ", data_name)); flush(stdout);

# Types are provided explicitly only to reduce memory use when parsing
x = filereader(src_grp, types=[Characters{5}, Characters{5}, Characters{12}, Int32, Int32, Int32, Int32, Int32, Float64]);
for i in 1:3
    x[!, i] = PooledArray(x[!, i])
end
in_rows = size(x, 1);
println(in_rows); flush(stdout);

task_init = time();
print("grouping...\n"); flush(stdout);

# question = "sum v1 by id1"; # q1
# GC.gc(false);
# t = @elapsed (ANS = combine(gatherby(x, :id1), :v1 => sum => :v1); println(size(ANS)); flush(stdout));
# m = memory_usage();
# chkt = @elapsed chk = sum(ANS.v1.val, threads=true);
# write_log(1, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
# ANS = 0;
# GC.gc(false);
# t = @elapsed (ANS = combine(gatherby(x, :id1), :v1 => sum => :v1); println(size(ANS)); flush(stdout));
# m = memory_usage();
# chkt = @elapsed chk = sum(ANS.v1.val, threads=true);
# write_log(2, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
# println(first(ANS, 3));
# println(last(ANS, 3));
# ANS = 0;

# question = "sum v1 by id1:id2"; # q2
# GC.gc(false);
# t = @elapsed (ANS = combine(gatherby(x, [:id1, :id2]), :v1 => sum => :v1); println(size(ANS)); flush(stdout));
# m = memory_usage();
# chkt = @elapsed chk = sum(ANS.v1.val, threads=true);
# write_log(1, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
# ANS = 0;
# GC.gc(false);
# t = @elapsed (ANS = combine(gatherby(x, [:id1, :id2]), :v1 => sum => :v1); println(size(ANS)); flush(stdout));
# m = memory_usage();
# chkt = @elapsed chk = sum(ANS.v1.val, threads=true);
# write_log(2, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
# println(first(ANS, 3));
# println(last(ANS, 3));
# ANS = 0;

# question = "sum v1 mean v3 by id3"; # q3
# GC.gc(false);
# t = @elapsed (ANS = combine(gatherby(x, :id3), :v1 => sum => :v1, :v3 => mean => :v3); println(size(ANS)); flush(stdout));
# m = memory_usage();
# chkt = @elapsed chk = [sum(ANS.v1.val, threads=true), sum(ANS.v3.val, threads=true)];
# write_log(1, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
# ANS = 0;
# GC.gc(false);
# t = @elapsed (ANS = combine(gatherby(x, :id3), :v1 => sum => :v1, :v3 => mean => :v3); println(size(ANS)); flush(stdout));
# m = memory_usage();
# chkt = @elapsed chk = [sum(ANS.v1.val, threads=true), sum(ANS.v3.val, threads=true)];
# write_log(2, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
# println(first(ANS, 3));
# println(last(ANS, 3));
# ANS = 0;

# question = "mean v1:v3 by id4"; # q4
# GC.gc(false);
# t = @elapsed (ANS = combine(gatherby(x, :id4), :v1 => mean => :v1, :v2 => mean => :v2, :v3 => mean => :v3); println(size(ANS)); flush(stdout));
# m = memory_usage();
# t_start = time_ns();
# chkt = @elapsed chk = [sum(ANS.v1.val, threads=true), sum(ANS.v2.val, threads=true), sum(ANS.v3.val, threads=true)];
# write_log(1, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
# ANS = 0;
# GC.gc(false);
# t = @elapsed (ANS = combine(gatherby(x, :id4), :v1 => mean => :v1, :v2 => mean => :v2, :v3 => mean => :v3); println(size(ANS)); flush(stdout));
# m = memory_usage();
# chkt = @elapsed chk = [sum(ANS.v1.val, threads=true), sum(ANS.v2.val, threads=true), sum(ANS.v3.val, threads=true)];
# write_log(2, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
# println(first(ANS, 3));
# println(last(ANS, 3));
# ANS = 0;

# question = "sum v1:v3 by id6"; # q5
# GC.gc(false);
# t = @elapsed (ANS = combine(groupby(x, :id6, stable=false), :v1 => sum => :v1, :v2 => sum => :v2, :v3 => sum => :v3); println(size(ANS)); flush(stdout));
# m = memory_usage();
# chkt = @elapsed chk = [sum(ANS.v1.val, threads=true), sum(ANS.v2.val, threads=true), sum(ANS.v3.val, threads=true)];
# write_log(1, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
# ANS = 0;
# GC.gc(false);
# t = @elapsed (ANS = combine(groupby(x, :id6, stable=false), :v1 => sum => :v1, :v2 => sum => :v2, :v3 => sum => :v3); println(size(ANS)); flush(stdout));
# m = memory_usage();
# chkt = @elapsed chk = [sum(ANS.v1.val, threads=true), sum(ANS.v2.val, threads=true), sum(ANS.v3.val, threads=true)];
# write_log(2, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
# println(first(ANS, 3));
# println(last(ANS, 3));
# ANS = 0;

question = "median v3 sd v3 by id4 id5"; # q6
GC.gc(false);
t = @elapsed (ANS = combine(groupby(x, [:id4, :id5], stable=false), :v3 => median! => :median_v3, :v3 => std => :sd_v3); println(size(ANS)); flush(stdout));
m = memory_usage();
chkt = @elapsed chk = [sum(ANS.median_v3.val, threads=true), sum(ANS.sd_v3.val, threads=true)];
write_log(1, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
ANS = 0;
GC.gc(false);
t = @elapsed (ANS = combine(groupby(x, [:id4, :id5], stable=false), :v3 => median! => :median_v3, :v3 => std => :sd_v3); println(size(ANS)); flush(stdout));
m = memory_usage();
chkt = @elapsed chk = [sum(ANS.median_v3.val, threads=true), sum(ANS.sd_v3.val, threads=true)];;
write_log(2, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
println(first(ANS, 3));
println(last(ANS, 3));
ANS = 0;

question = "max v1 - min v2 by id3"; # q7
GC.gc(false);
t = @elapsed (ANS = combine(gatherby(x, :id3), [:v1, :v2] .=> [maximum, minimum], 2:3=>byrow(-)=> :range_v1_v2); println(size(ANS)); flush(stdout));
m = memory_usage();
chkt = @elapsed chk = sum(ANS.range_v1_v2.val, threads=true);
write_log(1, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
ANS = 0;
GC.gc(false);
t = @elapsed (ANS = combine(gatherby(x, :id3), [:v1, :v2] .=> [maximum, minimum], 2:3=>byrow(-)=> :range_v1_v2); println(size(ANS)); flush(stdout));
m = memory_usage();
chkt = @elapsed chk = sum(ANS.range_v1_v2.val, threads=true);
write_log(2, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
println(first(ANS, 3));
println(last(ANS, 3));
ANS = 0;

question = "largest two v3 by id6"; # q8
GC.gc(false);
t = @elapsed (ANS = combine(groupby(x, :id6, stable=false), :v3 => (x -> partialsort!(x, 1:min(2, IMD.n(x)), by = y->-y)) => :largest2_v3); println(size(ANS)); flush(stdout));
m = memory_usage();
chkt = @elapsed chk = sum(ANS.largest2_v3.val, threads=true);
write_log(1, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
ANS = 0;
GC.gc(false);
t = @elapsed (ANS = combine(groupby(x, :id6, stable=false), :v3 => (x -> partialsort!(x, 1:min(2, IMD.n(x)), by = y->-y)) => :largest2_v3); println(size(ANS)); flush(stdout));
m = memory_usage();
chkt = @elapsed chk = sum(ANS.largest2_v3.val, threads=true);
write_log(2, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
println(first(ANS, 3));
println(last(ANS, 3));
ANS = 0;

question = "regression v1 v2 by id2 id4"; # q9
function cor2(x, y) ## 73647e5a81d4b643c51bd784b3c8af04144cfaf6
    nm = @. !ismissing(x) & !ismissing(y)
    return count(nm) < 2 ? NaN : cor(view(x, nm), view(y, nm))
end
GC.gc(false);
t = @elapsed (ANS = combine(groupby(x, [:id2, :id4], stable=false), (:v1, :v2) => ((v1,v2) -> cor2(v1, v2)^2) => :r2); println(size(ANS)); flush(stdout));
m = memory_usage();
chkt = @elapsed chk = sum(ANS.r2.val, threads=true);
write_log(1, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
ANS = 0;
GC.gc(false);
t = @elapsed (ANS = combine(groupby(x, [:id2, :id4], stable=false), (:v1, :v2) => ((v1,v2) -> cor2(v1, v2)^2) => :r2); println(size(ANS)); flush(stdout));
m = memory_usage();
chkt = @elapsed chk = sum(ANS.r2.val, threads=true);
write_log(2, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
println(first(ANS, 3));
println(last(ANS, 3));
ANS = 0;

question = "sum v3 count by id1:id6"; # q10
GC.gc(false);
t = @elapsed (ANS = combine(gatherby(x, 1:6, stable=false), :v3 => sum => :v3, :v3 => length => :count); println(size(ANS)); flush(stdout));
m = memory_usage();
chkt = @elapsed chk = [sum(ANS.v3.val, threads=true), sum(ANS.count.val, threads=true)];
write_log(1, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
ANS = 0;
GC.gc(false);
t = @elapsed (ANS = combine(gatherby(x, 1:6, stable=false), :v3 => sum => :v3, :v3 => length => :count); println(size(ANS)); flush(stdout));
m = memory_usage();
chkt = @elapsed chk = [sum(ANS.v3.val, threads=true), sum(ANS.count.val, threads=true)];
write_log(2, task, data_name, in_rows, question, size(ANS, 1), size(ANS, 2), solution, ver, git, fun, t, m, cache, make_chk(chk), chkt, on_disk);
println(first(ANS, 3));
println(last(ANS, 3));
ANS = 0;

print(@sprintf "grouping finished, took %.0fs\n" (time()-task_init)); flush(stdout);

exit();
