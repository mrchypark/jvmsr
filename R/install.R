#' download jvms binary
#' 
#' @param path where to set jvms binary. Defualt is $HOME/.jvms
#' @param force download function check if already exist. So force is TRUE means ignore previous binary.
#' @importFrom httr GET content
#' @importFrom fs path path_home dir_create file_delete
#' @importFrom zip unzip
#' @importFrom utils download.file
#' @export
#' @examples 
#' \dontrun{
#'   download()
#'   }
download <- function(path = jvms_loc(), force = F){
  if (check_jvms()&!force) {
    message("jvms already installed!")
  } else {
    info <- httr::GET("https://api.github.com/repos/ystyle/jvms/releases/latest")
    cont <- httr::content(info)
    tar_url <- cont$assets[[1]]$browser_download_url
    dir_loc <- path
    fs::dir_create(dir_loc)
    loc <- fs::path(dir_loc, "jvms", ext = "zip")
    utils::download.file(tar_url, destfile = loc, mode = "wb")
    zip::unzip(loc, exdir = dir_loc)
    fs::file_delete(loc)
  }
}

#' @importFrom fs file_exists path
check_jvms <- function(path = jvms_loc()){
  as.logical(fs::file_exists(fs::path(path,"jvms",ext="exe")))
}

#' @importFrom fs path_home path
jvms_loc <- function() {
  fs::path(fs::path_home(), ".jvms")
}


