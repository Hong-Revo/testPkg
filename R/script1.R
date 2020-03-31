#' Calls pkgdepends::new_pkg_installation_proposal
#' @param refs Package references.
#' @param snapshot MRAN snapshot date.
#' @param destdir Directory where packages are to be installed.
#' @export
pkg_inst <- function(refs, snapshot, destdir)
{
    snapshot <- file.path("https://mran.microsoft.com/snapshot", snapshot)
    pkgdepends::new_pkg_installation_proposal(
        refs,
        config=list(`cran-mirror`=snapshot,
        library=destdir)
    )
}
