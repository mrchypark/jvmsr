#' @importFrom httr GET content
#' @importFrom fs path path_home dir_create file_delete
#' @importFrom zip unzip
#' 
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
    download.file(tar_url, destfile = loc, mode = "wb")
    zip::unzip(loc, exdir = dir_loc)
    fs::file_delete(loc)
  }
}

check_jvms <- function(path = jvms_loc()){
  as.logical(fs::file_exists(fs::path(path,"jvms",ext="exe")))
}

jvms_loc <- function() {
  fs::path(fs::path_home(), ".jvms")
}


