#' Calls pkgdepends::new_pkg_installation_proposal
#' @param refs Package references.
#' @param snapshot MRAN snapshot date.
#' @param destdir Directory where packages are to be installed.
#' @param config Additional configuration options.
#' @export
pkg_inst <- function(refs, snapshot, destdir, config=list())
{
    snapshot <- file.path("https://mran.microsoft.com/snapshot", snapshot)
    config <- utils::modifyList(config, list(`cran-mirror`=snapshot, library=destdir))
    pkgdepends::new_pkg_installation_proposal(refs, config=config)
}
