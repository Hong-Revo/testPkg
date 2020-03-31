context("Mac test failure")

snapshot <- "2020-01-01"

test_that("GitHub overwriting nonexistent package install",
{
    skip_on_cran()

    pkgcache::pkg_cache_delete_files()

    refs <- c("rlang", "testpkg", "github::RevolutionAnalytics/checkpoint@testpkg")
    libdir <- tempfile()

    inst <- pkg_inst(refs, snapshot, libdir)
    expect_is(inst, "pkg_installation_proposal")

    jsonlite::toJSON(inst$get_config(), auto_unbox=TRUE, force=TRUE)

    inst$resolve()
    expect_is(res <- inst$get_resolution(), "pkg_resolution_result")
    jsonlite::toJSON(res, null="null", auto_unbox=TRUE, force=TRUE)

    inst$solve()
    expect_is(sol <- inst$get_solution(), "pkg_solution_result")
    jsonlite::toJSON(sol, null="null", auto_unbox=TRUE, force=TRUE)

    inst$download()
    expect_is(dl <- inst$get_downloads(), "pkgplan_downloads")
    jsonlite::toJSON(dl, null="null", auto_unbox=TRUE, force=TRUE)

    expect_is(insp <- inst$get_install_plan(), "pkgplan_downloads")
    jsonlite::toJSON(insp, null="null", force=TRUE)

    expect_is(ins <- inst$install(), "pkginstall_result")
    jsonlite::toJSON(ins, null="null", auto_unbox=TRUE, force=TRUE)
})


teardown({
    pkgcache::pkg_cache_delete_files()
})



