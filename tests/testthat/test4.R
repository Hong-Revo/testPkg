context("Mac testing with old snapshot in withr")

if(Sys.info()["sysname"] != "Darwin") skip("Not on Mac")

old_snapshot <- "2018-01-01"

test_that("Mac install with old snapshot",
{
    skip_on_cran()

    pkgcache::pkg_cache_delete_files()

    refs <- "cran::rlang"
    libdir <- tempfile()

    withr::with_options(list(repos=NULL),
    {
        inst <- pkg_inst(refs, old_snapshot, libdir)
#        expect_is(inst, "pkg_installation_proposal")

        inst$resolve()
        expect_is(inst$get_resolution(), "pkg_resolution_result")

        inst$solve()
        expect_is(inst$get_solution(), "pkg_solution_result")

        inst$download()
        expect_is(inst$get_downloads(), "pkgplan_downloads")

        expect_is(inst$install(), "pkginstall_result")
    })
})


teardown({
    pkgcache::pkg_cache_delete_files()
})
