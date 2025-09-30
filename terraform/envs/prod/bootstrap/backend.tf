terraform {
  cloud {
    organization = "devopssean"
    workspaces {
      name = "bootstrap"
    }
  }
}