context("Context")

snapshot <- "2020-01-01"

test_that("Simple install",
{
    skip_on_cran()

    pkgcache::pkg_cache_delete_files()

    refs <- "rlang"
    libdir <- tempfile()

    inst <- pkg_inst(refs, snapshot, libdir)
    expect_is(inst, "pkg_installation_proposal")

    inst$resolve()
    expect_is(inst$get_resolution(), "pkg_resolution_result")

    inst$solve()
    expect_is(inst$get_solution(), "pkg_solution_result")

    inst$download()
    expect_is(inst$get_downloads(), "pkgplan_downloads")

    expect_is(inst$install(), "pkginstall_result")
})


test_that("GitHub install",
{
    skip_on_cran()

    pkgcache::pkg_cache_delete_files()

    refs <- c("rlang", "github::RevolutionAnalytics/checkpoint@testpkg")
    libdir <- tempfile()

    inst <- pkg_inst(refs, snapshot, libdir)
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



