
jvms <- function(args = "", jvms = "auto"){
  if ( jvms == "auto") {
    jvms <- jvms_binary()
  }
  args <- strsplit(args, " ")[[1]]
  sys::exec_wait(jvms, args = args)
}

jvms_init <- function(){
  sys::exec_wait("rm", args = "C:/Program Files/jdk")
}

jvms_binary <- function(path = jvms_loc()) {
  fs::path(path,"jvms",ext="exe")
}