context("Mac testing with old snapshot from source")

if(Sys.info()["sysname"] != "Darwin") skip("Not on Mac")

old_snapshot <- "2018-01-01"

test_that("Mac install with old snapshot from source",
{
    skip_on_cran()

    pkgcache::pkg_cache_delete_files()

    refs <- "rlang"
    libdir <- tempfile()

    inst <- pkg_inst(refs, old_snapshot, libdir, config=list(platforms="source"))
    expect_is(inst, "pkg_installation_proposal")

    inst$resolve()
    expect_is(inst$get_resolution(), "pkg_resolution_result")

    inst$solve()
    expect_is(inst$get_solution(), "pkg_solution_result")

    inst$download()
    expect_is(inst$get_downloads(), "pkgplan_downloads")

    expect_is(inst$install(), "pkginstall_result")
})


teardown({
    pkgcache::pkg_cache_delete_files()
})
